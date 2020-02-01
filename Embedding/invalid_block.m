function [block_img]=invalid_block(block_img,t,t_c)
if nargin==1
    t=3;
    t_c=3;
end
 for i=2:t
        for j=1:t_c
            block_img(i,j)=uint8(int16(block_img(1,j)));
        end
 end
end