function [charac, ch]=MP_Generation(img,t,t_c)
if nargin==1, t=3; t_c=3; end
%valid=1;
load charac;
[hh,ww]=size(img);
z=zeros(t,t_c);

cha=1;
ch=1;
cw=1;
c1=0;

while cha~=(length(charac)+1)
    im =img(ch:ch+t-1,cw:cw+t_c-1);
    test1=im;
    test1=reshape(test1,1,t*t_c);
    test1=dec2bin(test1,8);
    for j=1:t*t_c, test1(j,6:end)='0';end
    
    test1=bin2dec(test1);
    test1=reshape(test1,t,t_c);
    
    for i=2:t
        for j=1:t_c
            test(i,j)=int16(test1(i,j)-test1(i-1,j));
            if (abs( test(i,j))>24)
                c1=1;
            end
        end
    end
    if(test==z)
            c1=1;
    else
    for i=1:cha-1
        test2=charac(i).mat;
        if(test2==test), c1=1;break;end
    end
    end

    if c1==0
        charac(cha).mat =test;
        cha=cha+1;
    end
    c1=0;
    
    cw=cw+1;
    if cw+t_c-1>ww
        cw=1;ch=ch+1;
    end

    if ((ch+t-1) > hh), ch=0;return; end
    
end  
end
