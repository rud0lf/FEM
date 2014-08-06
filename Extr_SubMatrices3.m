%This script finds out the submatrix of kglob,cglob,khglob and the sub force vector required for solving nodal
%values
bc=zeros(1,nodes);
j=1;
for i=1:nodes
    if p(1,i)>=2 && p(2,i)==0 && p(1,i)<=4
        bc(j)=i;
        j=j+1;
    end
end
j=j-1;
bc=bc(1,1:j);
kglobsub=zeros(nodes-j,nodes);
cglobsub=zeros(nodes-j,nodes);
khglobsub=zeros(nodes-j,nodes);
fhglobsub=zeros(nodes-j,1);
j=1;
for i=1:nodes
    flag=find(bc==i);
    if flag>0
        continue;
    else
        kglobsub(j,:)=kglob(i,:);
        cglobsub(j,:)=cglob(i,:);
        khglobsub(j,:)=khglob(i,:);
        fhglobsub(j)=fhglob(i);
        j=j+1;
    end
end
bc=sort(bc);
col=nodes-size(bc,2);
row=size(kglobsub,1);
kglobsubun=zeros(row,col);
khglobsubun=zeros(row,col);
cglobsubun=zeros(row,col);
%This code extracts the matrix that is to multiplied by the unknown
%temperature vector
j=1;
for i=1:nodes
    flag=find(bc==i);
    if flag>0
        continue;
    else
        kglobsubun(:,j)=kglobsub(:,i);
        khglobsubun(:,j)=khglobsub(:,i);
        cglobsubun(:,j)=cglobsub(:,i);
        j=j+1;
    end
end
kglobsubkn=zeros(row,size(bc,2));
khglobsubkn=zeros(row,size(bc,2));
%This code extracts the matrix that is to be multiplied with the known
%temperatures
k=1;
for j=1:row
    for i=1:nodes
        flag=find(bc==i);
        if flag>0
            
            kglobsubkn(j,k)=kglobsub(j,i);
            khglobsubkn(j,k)=khglobsub(j,i);
            
            k=k+1;
        else
            
            continue;
        end
    end
    k=1;
end
kglobalun=kglobsubun+khglobsubun;
kglobalkn=kglobsubkn+khglobsubkn;

        
