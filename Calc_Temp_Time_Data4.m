tknown=zeros(size(bc,2),1);
for i=1:size(bc,2)
    tknown(i)=100*p(1,bc(1,i));             %tknown-->Temperature of the known nodes(temperature boundary conditions)
end
tknown=kglobalkn*tknown;        
fglobal=fhglobsub-tknown;                   %fglobal is the global load vector
fglobal=cglobsubun\fglobal;
kglobalun=cglobsubun\kglobalun;
tsize=size(kglobalun,1);
ti=ones(tsize,1);
ti=ti*20;
data=zeros(489,1000);                        %data is the matrix that holds the temperature of all the nodes at particular instants of time 
dt=5;                                       %Step Size for forward scheme time marching algo
j=1;
for i=1:20000
    tplusdt=ti+dt*(-kglobalun*ti+fglobal);  %forward scheme time marching algorithm
    ti=tplusdt;                             %Calculated temperature of all the nodes at ith step
    tif=zeros(489,1);                       %This will hold the temperature of all the nodes including the known ones(489=total nodes)
    l=1;
%Code to insert the already known temperatures of the nodes into tif for completing temperature vector     
for k=1:nodes
    if find(bc==k)>0                                       
        tif(k)=100*p(1,k);
    else
        tif(k)=ti(l);
        l=l+1;
    end
end
   
    if mod(i,20)==0                         %Inserting temperature data into data matrix
        data(:,j)=tif;
        j=j+1;
    end
    
end
