function [img, txt, continue_t]=Embedding_orderblocks(charac,txt,img,t,t_c)
if nargin==3
t=3;
t_c=2;
end
t_txt='';
h=1;w=1;
[hh,ww]=size(img);
continue_t=1;
ch_num=floor(hh/t)*floor(ww/t_c);
num=ch_num;

while ((~isempty(txt) && (num)~=0))
    invalid_blo=0;
    for j=1:12
        if (txt(1)==charac(j).hi)
            im=img((h-1)*t+1:(h-1)*t+t,(w-1)*t_c+1:(w-1)*t_c+t_c);
            im_t=im;
            for i1=2:t
                for j1=1:t_c
                    t_img=(int16(im(i1-1,j1))+int16(charac(j).mat(i1,j1)));
                    im(i1,j1)=uint8(t_img);
                    if(t_img>255 || t_img<0)
                        invalid_blo=1;
                    end
                end
            end 
            if(invalid_blo==1)
                 im=Null_Matrix(im_t,t,t_c);
            end
            break;
        end
    end
    img((h-1)*t+1:(h-1)*t+t,(w-1)*t_c+1:(w-1)*t_c+t_c)=im;
    w=w+1;
    num=num-1;

    if w*t_c>ww
        w=1;h=h+1;
    end
if(invalid_blo==0)
    t_txt=[t_txt txt(1)];
    txt(1)='';
end
end

% this part use for putting the end of block point or end of text point

if(isempty(txt)==1)
    if(num~=0) 
        invalid_blo=1;
        while(invalid_blo==1 && num~=0)
            invalid_blo=0;
            im=img((h-1)*t+1:(h-1)*t+t,(w-1)*t_c+1:(w-1)*t_c+t_c);
            im_t=im;
            for i=2:t
                for j=1:t_c
                    img_t=(int16(im(i-1,j))+int16(charac(1).mat(i,j)));
                    im(i,j)=uint8(img_t);
                    if(img_t>255 || img_t<0)
                        invalid_blo=1;
                    end
                end
            end
            if(invalid_blo==1)
                im=Null_Matrix(im_t,t,t_c);
            end
            img((h-1)*t+1:(h-1)*t+t,(w-1)*t_c+1:(w-1)*t_c+t_c)=im;
            num=num-1;
            w=w+1;
            if w*t_c>ww
                w=1;h=h+1;
            end
            if(num==0 && invalid_blo==1)
                continue_t=0;  % When all the secret message characters are embedded, but the block did not have more space to hide the "end of message" pattern in this block, in this case, we embed the "end of message" pattern in the next selected B by B block. If the current B by B block is the last block in this image or the next block(s) does not have any space for hiding, no error will happen.
            end
        end
    end
else
    continue_t=0; % if the last t1xt2 matrix of this block is used for hiding the last character of the message
end
end
