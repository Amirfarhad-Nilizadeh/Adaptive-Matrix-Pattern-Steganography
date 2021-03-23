function [queue_MP_w_f, queue_MP_h_f] = Preprocessing_algorithm(img,t1)
if nargin==1, t1=64;t2=64; end
img_i=Intensity(img);
t2=t1;

[row_size,column_size]=size(img_i);

nh=fix(row_size/t1);
nw=fix(column_size/t2);

numh=[];
numw=[];
count=0;
numh1=[];
numw1=[];
count1=0;

numh2=[];
numw2=[];
count2=0;

numh3=[];
numw3=[];
count3=0;

e_s_w1=[];
e_s_h1=[];
e_s_w2=[];
e_s_h2=[];
e_s_w3=[];
e_s_h3=[];

e_c_w1=[];
e_c_h1=[];
e_c_w2=[];
e_c_h2=[];
e_c_w3=[];
e_c_h3=[];

s_c_w1=[];
s_c_h1=[];
s_c_w2=[];
s_c_h2=[];
s_c_w3=[];
s_c_h3=[];

s_s_w1=[];
s_s_h1=[];
s_s_w2=[];
s_s_h2=[];
s_s_w3=[];
s_s_h3=[];

count_e_s_1=0;
count_e_s_2=0;
count_e_s_3=0;
count_e_c_1=0;
count_e_c_2=0;
count_e_c_3=0;
count_s_c_1=0;
count_s_c_2=0;
count_s_c_3=0;
count_s_s_1=0;
count_s_s_2=0;
count_s_s_3=0;

queue_MP_h_f=[];
queue_MP_w_f=[];

flag_q=0;
MPqueue=[];

vector=(t1-1)*t2; % Maximum of Vertical changes
horizontal=(t2-1)*t1;% Maximum of Horizontal changes 
di_1=(t1-1)*(t1-1);% Maximum of Diameter changes
di_2=di_1;
total=horizontal+di_1+di_2;


for row_size=1:nh
    for column_size=1:nw
        im =img_i((row_size-1)*t1+1:(row_size-1)*t1+t1,(column_size-1)*t2+1:(column_size-1)*t2+t2);
        [h,w]=size(im);
        im_t=im;

        g=0;
        for i=1:h
            for j=1:w
                g=g+double(im_t(i,j));
            end
        end
        tr=g/(h*w);
        
        test=zeros(h,w);
        for i=1:h
            for j=1:w
                if(im_t(i,j)<tr),test(i,j)=0;else test(i,j)=1; end
            end
        end
        test=boolean(test);
        nu1=0;
        nu2=0;
        dia_1=0;
        dia_2=0;
        for i=1:h
            for j=1:w-1
                if test(i,j)~= test(i,j+1)
                    nu1=nu1+1;   % Horizontal changes 
                end
            end
        end
         for i=1:h-1
            for j=1:w
                 if test(i,j)~= test(i+1,j)
                    nu2=nu2+1;   %Vertical Changes
                end
            end
         end
         
for i=1:h % Diameter changes,started from the upper left corner of the binary block
    z=i;
    for j=1:h-z
        if test(i+j-1,j)~= test(i+j,j+1)
            dia_1=dia_1+1;
        end
    end
end
for i=2:h
    z=i;
    for j=1:h-z
        if test(j, i+j-1)~=test(j+1,j+i)
            dia_1=dia_1+1;
        end
    end
end
  
z=h+1;   % Diameter changes,started from the upper right corner of the binary block
for i=1:h
    z=z-1;
    for j=1:h-i
        if test(j,abs(z-j)+1)~=test(j+1,abs(z-j))
            dia_2=dia_2+1;
        end
    end
end


for i=2:h
    z=h+1;
    for j=1:h-i
        z=z-1;
        if test(i+j-1,z)~=test(i+j,z-1)
            dia_2=dia_2+1;
        end
    end
end

vec=nu1/vector;
hor=nu2/horizontal;
diag1=  dia_1/di_1;
diag2=  dia_2/di_2;
tota=nu1+nu2+dia_1+dia_2;
sum_up=tota/total;


arr=reshape(im,1,[]);
variance=var(double(arr));

 if(variance<250 && sum_up<=0.5) %smooth and simple 
    if(variance<250 && sum_up<=0.5 && sum_up>0.3)
        s_s_w1=[s_s_w1 column_size];
        s_s_h1=[s_s_h1 row_size];
        count_s_s_1=count_s_s_1 +1;
    elseif (variance<250 && sum_up<=0.3 && sum_up>0.15)
        s_s_w2=[s_s_w2 column_size];
        s_s_h2=[s_s_h2 row_size];
        count_s_s_2=count_s_s_2 +1;
    else
        s_s_w3=[s_s_w3 column_size];
        s_s_h3=[s_s_h3 row_size];
        count_s_s_3=count_s_s_3 +1;
    end
        
       numw2=[numw2 column_size];
     numh2=[numh2 row_size];
      count2=count2+1;
 end
 
  if(variance>=250 && sum_up>0.5) % Edge & complex 
       if(variance>=1000 && sum_up>0.5)
           e_c_w1=[e_c_w1 column_size];
           e_c_h1=[e_c_h1 row_size];
           count_e_c_1=count_e_c_1+1;
       elseif(variance>=600 && sum_up>0.5)
           e_c_w2=[e_c_w2 column_size];
           e_c_h2=[e_c_h2 row_size];
           count_e_c_2=count_e_c_2+1;
       else
           e_c_w3=[e_c_w3 column_size];
           e_c_h3=[e_c_h3 row_size];
           count_e_c_3=count_e_c_3+1;
       end
      numw1=[numw1 column_size];
      numh1=[numh1 row_size];
      count1=count1+1;
  end
   
   if(variance<250 && sum_up>0.5)% smooth and complex 
      if(variance<250 && sum_up>0.65)
          s_c_w1=[s_c_w1 column_size];
          s_c_h1=[s_c_h1 row_size];
          count_s_c_1=count_s_c_1+1;
      elseif(variance<250 && sum_up>=0.5)
          s_c_w2=[s_c_w2 column_size];
          s_c_h2=[s_c_h2 row_size];
          count_s_c_2=count_s_c_2+1;
      else
          s_c_w3=[s_c_w3 column_size];
          s_c_h3=[s_c_h3 row_size];
          count_s_c_3=count_s_c_3+1;
      end
      numw3=[numw3 column_size];
      numh3=[numh3 row_size];
      count3=count3+1;
   end
 

   if(variance>=250 && sum_up<=0.5) % Edge and simple 
       if(variance>=1000 && sum_up<=0.5 && sum_up>=0.3)
           e_s_w1=[e_s_w1 column_size];
           e_s_h1=[e_s_h1 row_size];
           count_e_s_1=count_e_s_1+1;
       elseif(variance>=700 && sum_up<0.3 && sum_up>=0.15)
           e_s_w2=[e_s_w2 column_size];
           e_s_h2=[e_s_h2 row_size];
           count_e_s_2=count_e_s_2+1;
       else
           e_s_w3=[e_s_w3 column_size];
           e_s_h3=[e_s_h3 row_size];
           count_e_s_3=count_e_s_3+1;
       end
      numw=[numw column_size];
      numh=[numh row_size];
      count=count+1;
   end 
  end %***********************************************************************
end %**************************************************************************

 queue_MP_w_f=[s_c_w1 s_c_w2 s_c_w3 e_c_w1 e_c_w2 e_c_w3 e_s_w1 e_s_w2 e_s_w3  s_s_w1  s_s_w2  s_s_w3];
 queue_MP_h_f=[s_c_h1 s_c_h2 s_c_h3 e_c_h1 e_c_h2 e_c_h3 e_s_h1 e_s_h2 e_s_h3  s_s_h1  s_s_h2  s_s_h3];
end

