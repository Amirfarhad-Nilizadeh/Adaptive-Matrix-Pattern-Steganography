%This function is used for eleminating orderblocks form 
function [queue_MP_w_f queue_MP_h_f] = Eliminating_blocks_with_overlap_by_orderblocks(img,t1,t2,t3,a11,a21,a12,a22)
if nargin==4, t1=64;t2=64;t3=48; end

img_i=Intensity(img);

[hh,ww]=size(img_i);

nh=fix(hh/t1);
nw=fix(ww/t2);

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

q=length(a11);


flag_q=0;
MPqueue=[];

vector=(t1-1)*t2; % maximum halat ofoghi
horizontal=(t2-1)*t1;% maximum halat amodi
di_1=(t1-1)*(t1-1);% maximum halat ghotri
%for i=1:t1-2
   % di_1=di_1+(2*i);
%end
di_2=di_1;
total=horizontal+di_1+di_2;




for hh=1:nh
    for ww=1:nw
        im =img_i((hh-1)*t1+1:(hh-1)*t1+t1,(ww-1)*t2+1:(ww-1)*t2+t2);
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
                    nu1=nu1+1;   % taghirat satri
                end
            end
        end
         for i=1:h-1
            for j=1:w
                 if test(i,j)~= test(i+1,j)
                    nu2=nu2+1;   %taghirat sotoni
                end
            end
         end
         
         
        
for i=1:h % baraye moghayese ghotri,start from upper left corner of binary block
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
  


z=h+1;   % baraye moghayese ghotri,start from upper right corner of binary block
for i=1:h
    z=z-1;
    for j=1:h-i;
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
   
%if (ww==11 && hh==20)
%    disp('stop');
%end
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
        s_s_w1=[s_s_w1 ww];
        s_s_h1=[s_s_h1 hh];
        count_s_s_1=count_s_s_1 +1;
    elseif (variance<250 && sum_up<=0.3 && sum_up>0.15)
        s_s_w2=[s_s_w2 ww];
        s_s_h2=[s_s_h2 hh];
        count_s_s_2=count_s_s_2 +1;
    else
        s_s_w3=[s_s_w3 ww];
        s_s_h3=[s_s_h3 hh];
        count_s_s_3=count_s_s_3 +1;
    end
        
       numw2=[numw2 ww];
      numh2=[numh2 hh];
      count2=count2+1;
 end
 
  if(variance>=250 && sum_up>0.5) % Edge & complexity %%% PVD/second step%%% red
       if(variance>=1000 && sum_up>0.5)
           e_c_w1=[e_c_w1 ww];
           e_c_h1=[e_c_h1 hh];
           count_e_c_1=count_e_c_1+1;
       elseif(variance>=600 && sum_up>0.5)
           e_c_w2=[e_c_w2 ww];
           e_c_h2=[e_c_h2 hh];
           count_e_c_2=count_e_c_2+1;
       else
           e_c_w3=[e_c_w3 ww];
           e_c_h3=[e_c_h3 hh];
           count_e_c_3=count_e_c_3+1;
       end
      numw1=[numw1 ww];
      numh1=[numh1 hh];
      count1=count1+1;
  end
   
   if(variance<250 && sum_up>0.5)% smooth and complex %%%% PVD/third step %%% blue
      if(variance<250 && sum_up>0.65)
          s_c_w1=[s_c_w1 ww];
          s_c_h1=[s_c_h1 hh];
          count_s_c_1=count_s_c_1+1;
      elseif(variance<250 && sum_up>0.5)
          s_c_w2=[s_c_w2 ww];
          s_c_h2=[s_c_h2 hh];
          count_s_c_2=count_s_c_2+1;
      else
          s_c_w3=[s_c_w3 ww];
          s_c_h3=[s_c_h3 hh];
          count_s_c_3=count_s_c_3+1;
      end
      numw3=[numw3 ww];
      numh3=[numh3 hh];
      count3=count3+1;
   end
 

   if(variance>=250 && sum_up<=0.5) % Edge and simple %%% PVD/ forth step %%% yellow
       if(variance>=1000 && sum_up<=0.5 && sum_up>=0.3)
           e_s_w1=[e_s_w1 ww];
           e_s_h1=[e_s_h1 hh];
           count_e_s_1=count_e_s_1+1;
       elseif(variance>=700 && sum_up<=0.3 && sum_up>=0.15)
           e_s_w2=[e_s_w2 ww];
           e_s_h2=[e_s_h2 hh];
           count_e_s_2=count_e_s_2+1;
       else
           e_s_w3=[e_s_w3 ww];
           e_s_h3=[e_s_h3 hh];
           count_e_s_3=count_e_s_3+1;
       end
      numw=[numw ww];
      numh=[numh hh];
      count=count+1;
   end
   
 
 
 end%***********************************************************************
end %**************************************************************************

% figure,
% imshow(img);
% hold on;
% for i=1:length(numh)
% 
% plot([(numw(i)-1)*t2+1 (numw(i)-1)*t2+t2 (numw(i)-1)*t2+t2 (numw(i)-1)*t2+1 (numw(i)-1)*t2+1],...
%          [(numh(i)-1)*t1+1 (numh(i)-1)*t1+1 (numh(i)-1)*t1+t1 (numh(i)-1)*t1+t1 (numh(i)-1)*t1+1],...
%          'y','LineWidth',2);
% end
% hold off;
% 
% hold on;
% for i=1:length(numh1)
% 
% plot([(numw1(i)-1)*t2+1 (numw1(i)-1)*t2+t2 (numw1(i)-1)*t2+t2 (numw1(i)-1)*t2+1 (numw1(i)-1)*t2+1],...
%          [(numh1(i)-1)*t1+1 (numh1(i)-1)*t1+1 (numh1(i)-1)*t1+t1 (numh1(i)-1)*t1+t1 (numh1(i)-1)*t1+1],...
%          'r','LineWidth',2);
% end
% hold off;
% 
% hold on;
% for i=1:length(numh2)
% 
% plot([(numw2(i)-1)*t2+1 (numw2(i)-1)*t2+t2 (numw2(i)-1)*t2+t2 (numw2(i)-1)*t2+1 (numw2(i)-1)*t2+1],...
%          [(numh2(i)-1)*t1+1 (numh2(i)-1)*t1+1 (numh2(i)-1)*t1+t1 (numh2(i)-1)*t1+t1 (numh2(i)-1)*t1+1],...
%          'g','LineWidth',2);
% end
% hold off;
% 
% hold on;
% for i=1:length(numh3)
% 
% plot([(numw3(i)-1)*t2+1 (numw3(i)-1)*t2+t2 (numw3(i)-1)*t2+t2 (numw3(i)-1)*t2+1 (numw3(i)-1)*t2+1],...
%          [(numh3(i)-1)*t1+1 (numh3(i)-1)*t1+1 (numh3(i)-1)*t1+t1 (numh3(i)-1)*t1+t1 (numh3(i)-1)*t1+1],...
%          'b','LineWidth',2);
% end
%  hold off;

 queue_MP_w=[s_c_w1 s_c_w2 s_c_w3 e_c_w1 e_c_w2 e_c_w3 e_s_w1 e_s_w2 e_s_w3  s_s_w1  s_s_w2  s_s_w3];
 queue_MP_h=[s_c_h1 s_c_h2 s_c_h3 e_c_h1 e_c_h2 e_c_h3 e_s_h1 e_s_h2 e_s_h3  s_s_h1  s_s_h2  s_s_h3];
 
 
 ft=length(queue_MP_w);
loos_blo=0;
if t1>t3 % dar in halat momken ast sare yeki az azlae block kochektar ke dar in halat blocki ast ke del,thr,b_s ra dar khod penhan karde ast dar block bozorgtar gharar girad. dakhel 
    for p=1:ft
        in11=(queue_MP_h(p)-1)*t1+1;
        in21=(queue_MP_h(p)-1)*t1+t1;
        in12=(queue_MP_w(p)-1)*t2+1;
        in22=(queue_MP_w(p)-1)*t2+t2;
    
    for z=1:q
        if (((in12<=a22(z)&& a22(z)<=in22 && in11<=a11(z)&& a11(z)<=in21)) || ((in12<=a22(z)&& a22(z)<=in22 && in11<=a21(z)&& a21(z)<=in21))||((in12<=a12(z)&& a12(z)<=in22 && in11<=a11(z)&&a11(z)<=in21)) || ((in12<=a12(z)&& a12(z)<=in22 && in11<=a21(z)&& a21(z)<=in21)))
            flag_q=1;
            count=count-1;
            loos_blo=loos_blo+1;
        end
    end
    if flag_q==0
        queue_MP_h_f=[queue_MP_h_f queue_MP_h(p)];
        queue_MP_w_f=[queue_MP_w_f queue_MP_w(p)];
    else
        flag_q=0;
    end
    end
elseif t3>t1
    for p=1:ft
        in11=(queue_MP_h(p)-1)*t1+1;
        in21=(queue_MP_h(p)-1)*t1+t1;
        in12=(queue_MP_w(p)-1)*t2+1;
        in22=(queue_MP_w(p)-1)*t2+t2;
   
    for z=1:q
       if (((a12(z)<= in22 && in22 <= a22(z) && a11(z)<= in11 && in11 <= a21(z))) || ((a12(z)<= in22 && in22 <= a22(z) && a11(z) <= in21 && in21 <= a21(z)))||((a12(z) <= in12 && in12 <= a22(z) && a11(z) <= in11 && in11 <= a21(z))) || ((a12(z) <= in12 && in12 <= a22(z) && a11(z) <= in21 && in21 <= a21(z))))
            flag_q=1;
            count=count-1;
            loos_blo=loos_blo+1;
        end
    end
     if flag_q==0
        queue_MP_h_f=[queue_MP_h_f queue_MP_h(p)];
        queue_MP_w_f=[queue_MP_w_f queue_MP_w(p)];
     else
         flag_q=0;
    end
    end
end
end