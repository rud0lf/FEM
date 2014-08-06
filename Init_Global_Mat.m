%Material-->Copper
%Thermal Conductivity-->kth=400W/(m.K)
%Specific Heat Capacity-->c=385J/(kg.K)
%Density-->rho=8960kg/m^3
%Convection Co-efficient of air=20W/(m^2.K)
%Thickness-->t=1m
%Length-->x2=6m
%Width-->x1=1m
%External temp-->to=20 C
to=20;
kth=400;
hth=25;
c=385;
rho=8000;
trcount=size(t,2);                                                          %Count the number of triangles
nodes=size(p,2);
kglob=zeros(nodes,nodes);
cglob=zeros(nodes,nodes);
%Calculating Kc-->K for conduction
for tr=1:trcount
    i=t(1,tr);
    j=t(2,tr);
    k=t(3,tr);
    D=[1 p(1,i) p(2,i);1 p(1,j) p(2,j);1 p(1,k) p(2,k)];
    detD=det(D);
    area=abs(detD/2);
    prod=rho*c*area*1/12;
    ai=(p(1,j)*p(2,k)-p(1,k)*p(2,j))/detD;
    bi=(p(2,j)-p(2,k))/detD;
    ci=(p(1,k)-p(1,j))/detD;
    aj=(p(1,k)*p(2,i)-p(1,i)*p(2,k))/detD;
    bj=(p(2,k)-p(2,i))/detD;
    cj=(p(1,i)-p(1,k))/detD;
    ak=(p(1,i)*p(2,j)-p(1,j)*p(2,i))/detD;
    bk=(p(2,i)-p(2,j))/detD;
    ck=(p(1,j)-p(1,i))/detD;
    %Calculating the components of the elemental matrix k
    ii=kth*area*(bi*bi+ci*ci);
    ij=kth*area*(bi*bj+ci*cj);
    ik=kth*area*(bi*bk+ci*ck);
    ji=kth*area*(bj*bi+cj*ci);
    jj=kth*area*(bj*bj+cj*cj);
    jk=kth*area*(bj*bk+cj*ck);
    ki=kth*area*(bk*bi+ck*ci);
    kj=kth*area*(bk*bj+ck*cj);
    kk=kth*area*(bk*bk+ck*ck);
    %Components of the elemental matrix c
    cii=2*prod;
    cij=1*prod;
    cik=1*prod;
    cji=1*prod;
    cjj=2*prod;
    cjk=1*prod;
    cki=1*prod;
    ckj=1*prod;
    ckk=2*prod;
    %directly placing the components of elemental matrices in global matrix
    kglob(i,i)=kglob(i,i)+ii;
    kglob(i,j)=kglob(i,j)+ij;
    kglob(i,k)=kglob(i,k)+ik;
    kglob(j,i)=kglob(j,i)+ji;
    kglob(j,j)=kglob(j,j)+jj;
    kglob(j,k)=kglob(j,k)+jk;
    kglob(k,i)=kglob(k,i)+ki;
    kglob(k,j)=kglob(k,j)+kj;
    kglob(k,k)=kglob(k,k)+kk;
    %Assembling cglob
    cglob(i,i)=cglob(i,i)+cii;
    cglob(i,j)=cglob(i,j)+cij;
    cglob(i,k)=cglob(i,k)+cik;
    cglob(j,i)=cglob(j,i)+cji;
    cglob(j,j)=cglob(j,j)+cjj;
    cglob(j,k)=cglob(j,k)+cjk;
    cglob(k,i)=cglob(k,i)+cki;
    cglob(k,j)=cglob(k,j)+ckj;
    cglob(k,k)=cglob(k,k)+ckk;
end
