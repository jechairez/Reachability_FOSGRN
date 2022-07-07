function [Basins,Basins_size]=GetBasin(L,r0,Att_Land,Number_Of_Genes,Att_Land_size)
for i=1:Att_Land_size
    L_proof=L^r0;
    row=find(L_proof.v==lm(((2^Number_Of_Genes)-bin2dec(num2str(Att_Land(i,:)))),2^Number_Of_Genes));
    %basin{:,i}=[((2^Number_Of_Genes)-bin2dec(num2str(Att_Land(i,:)))); row'];
    basin{:,i}=row';
    basinsize(i,:)=size(basin{:,i},1);
   
end
Basins=basin;
Basins_size=basinsize;
