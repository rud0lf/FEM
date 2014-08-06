%This script calculates the global matrix related to convection and the
%corresponding force vector
esize=size(e,2);
bound=zeros(3,esize);
j=1;
for i=1:esize
    if e(5,i)==4 || e(5,i)==3 || e(5,i)==8 || e(5,i)==9 || e(5,1)==10
        continue;
    else
        bound(1,j)=e(1,i);
        bound(2,j)=e(2,i);
        j=j+1;
    end
end
trbound=zeros(4,trcount);

boundsize=size(bound,2);
for i=1:boundsize
    for j=1:trcount
        for k=1:3
            if bound(1,i)==t(k,j)
                for l=1:3
                    if bound(2,i)==t(l,j)
                        trbound(1,j)=1;         %Set 1 if any 2 nodes match
                        trbound(2,j)=j;         %Which triangle got 2 nodes match
                        trbound(3,j)=k;         %Saving matching node number
                        trbound(4,j)=l;         %Saving matching node number
                    end
                end
            end
        end
    end
end
i=0;
j=0;
k=0;
khglob=zeros(nodes,nodes);
fhglob=zeros(nodes,1);
for tr=1:trcount
    if trbound(1,tr)==1
        if trbound(3,tr)==1
            i=t(1,tr);
        elseif trbound(3,tr)==2
            j=t(2,tr);
        else
            k=t(3,tr);
        end
        if trbound(4,tr)==1
            i=t(1,tr);
        elseif trbound(4,tr)==2
            j=t(2,tr);
        else
            k=t(3,tr);
        end
        if i==0
            s=((p(1,j)-p(1,k))^2+(p(2,j)-p(2,k))^2)^.5;
            sf=hth*to*s/2;
            s=s*hth;
            fhglob(j)=fhglob(j)+sf;
            fhglob(k)=fhglob(k)+sf;
            khglob(j,j)=khglob(j,j)+(1/3)*s;
            khglob(j,k)=khglob(j,k)+(1/6)*s;
            khglob(k,j)=khglob(k,j)+(1/6)*s;
            khglob(k,k)=khglob(k,k)+(1/3)*s;
        elseif j==0
            s=((p(1,i)-p(1,k))^2+(p(2,i)-p(2,k))^2)^.5;
            sf=hth*to*s/2;
            s=s*hth;
            fhglob(i)=fhglob(i)+sf;
            fhglob(k)=fhglob(k)+sf;
            khglob(i,i)=khglob(i,i)+(1/3)*s;
            khglob(i,k)=khglob(i,k)+(1/6)*s;
            khglob(k,i)=khglob(k,i)+(1/6)*s;
            khglob(k,k)=khglob(k,k)+(1/3)*s;
        else
            s=((p(1,i)-p(1,j))^2+(p(2,i)-p(2,j))^2)^.5;
            sf=hth*to*s/2;
            s=s*hth;
            fhglob(j)=fhglob(j)+sf;
            fhglob(i)=fhglob(i)+sf;
            khglob(i,i)=khglob(i,i)+(1/3)*s;
            khglob(i,j)=khglob(i,j)+(1/6)*s;
            khglob(j,i)=khglob(j,i)+(1/6)*s;    
            khglob(j,j)=khglob(j,j)+(1/3)*s;
        end
    else
        continue;
    end
end
