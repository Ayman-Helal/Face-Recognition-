clear;
clc;
%reading_images%
k=1;
for i=1:10;
  for j=1:14;
    if j<10
    B=strcat(int2str(i),'-0',int2str(j),'.jpg');
    r=imread(B);
    r=rgb2gray(r);
    r=double(r);
    y=reshape(r,[],1);
    z(:,k)=y;
    k=k+1;
  else
    B=strcat(int2str(i),'-',int2str(j),'.jpg');
    r=imread(B);
    r=rgb2gray(r);
    r=double(r);
    y=reshape(r,[],1);
    z(:,k)=y;
    k=k+1;
    endif
  endfor
endfor
%preparing_data%
m=mean(z,2);             
[q,s]=size(z);
R=repmat(m,1,s);      
a=z-R;
cov=a'*a;
[v,d]=eig(cov); 
d=diag(d);           
[s,y]=sort(d,'descend');
x=cumsum(s);
xs=sum(s);
x=(x./xs).*100;
w=find(x>90);
M=v(:,y(1:w(1)));
E=a*M;
EF=E'*a;
%testing%
I=imread('1-02.jpg');   
r1=rgb2gray(I);
r1=double(r1);
r1=reshape(r1,[],1);
A = r1-m;
Wt = E'*A;
distance = sum((repmat(Wt,1,size(EF,2)) - EF).^2);
[V,I] = min(distance);
        if V <= 4.1251e+17 
            G=ceil(I/4);
        else 
            G=0;
        end 
        if G == 1
           disp('Correct');
        else 
           disp('incorrect');
        end