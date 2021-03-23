clear
clc
D ='/Address of Cover Image/';

d = {'T', 'D'};
csvwrite ('Result-ten.ods', d);

S = dir(fullfile(D,'*.ppm')); 
Block_size = 128;
MP_size_row = 3;
MP_size_column = 2;

Block_size_orderblocks=64;
MP_size_row_orderblocks=3;
MP_size_column_orderblock=2;
Str_Block_size = num2str(Block_size);
Str_MP_size_row = num2str(MP_size_row);
Str_MP_size_column = num2str(MP_size_column);
Block_size_orderblock = 64;


for k = 1:10000
    file = fullfile(D,S(k).name);
    Cover_Image = imread(file); 
<<<<<<< HEAD

=======
>>>>>>> b23bdcb50dbaa19ba6612cf6a68cef5d9d807e23
Generating_random_text;
Secret_Message=fileread('random.txt');
[row_size_cover,column_size_cover]= size(Cover_Image(:,:,3));

<<<<<<< HEAD
=======
%Size_Checker= 1; %For checkin the values which are selected by user

% while(Size_Checker==1)
%     
%     Block_size=input('Enter a poitive integer number as a Block Size:\n');% Block_size = 64 is recommended 
%     while(fix(Block_size)-Block_size~=0 || Block_size<1)
%         display('Warning: Block Size should be a positive integere.');
%         Block_size=input('Enter a positive integer number as a Block Size (Block_size = 64 is recommended):\n');
%     end
%     
%     while(floor(row_size_cover/2)<Block_size && floor(column_size_cover/2)<Block_size)
%         display('Warning: Selected Block Size is not suitable based on size of Cover Image. Select a smaller Block Size');
%         Block_size=input('Enter a positive integer number as a Block Size (Block_size = 64 is recommended):\n');
%     end
%     
%     MP_size_row=input('Enter the Matrix Pattern Row Size:\n');% MP_size_row = 3 is recommended 
% 
%     while(fix(MP_size_row)-MP_size_row~=0 || MP_size_row<1)
%         display('Warning: Selected input should be a positive integere.');
%         MP_size_row=input('Enter a positive integer number as a Matrix Pattern Row size (3 is recommended):\n');
%     end
% 
%     MP_size_column=input('Enter the Matrix Pattern column Size:\n');% MP_size_column = 2 is recommended 
% 
%     while(fix(MP_size_column)-MP_size_column~=0 || MP_size_column<1)
%         display('Warning: Selected input should be a positive integere.');
%         MP_size_column=input('Enter a positive integer number as a Matrix Pattern column size (2 is recommended):\n');
%     end
% 
%     Size_Checker=0;
% 
%     if((Block_size-MP_size_row+1)*(Block_size-MP_size_column+1)<256 || MP_size_row>Block_size|| MP_size_column>Block_size ||(MP_size_row-1)*(MP_size_column)<3)
%         Size_Checker=1;
%         display('Warning: Selected sizes are not suitable, Please follow the instruction:');
%         display('1) Block size value should be greater than Row and Column sizes');
%         display('2) Generating 95 unique Matrix Pattern Based on selected Block size and Matrix Pattern sizes is impossible\n')
%         display('Please enter new values');
%     end
% end

>>>>>>> b23bdcb50dbaa19ba6612cf6a68cef5d9d807e23

tStart = tic;
temp_Cover_Image=Cover_Image;
[ww, hh]=Preprocessing_algorithm(Cover_Image,Block_size);
[HH,WW]=size(Cover_Image(:,:,3));
nw=fix(WW/Block_size);
nw_set=((fix(WW/Block_size_orderblock) * fix(HH/Block_size_orderblock)));
text1=[];
w=[];
h=[];
ww1=[];
hh1=[];
area11=[];
area12=[];
area21=[];
area22=[];
ob=0;
text1=Str_Block_size;
text1=[text1 ']'];
text1=[text1 Str_MP_size_row];
text1=[text1 ']'];
text1=[text1 Str_MP_size_column];
text1_temp=text1;

img_t=Cover_Image;
b_first=img_t(:,:,3);
b1_first=img_t(:,:,3);
img_g=img_t(:,:,2);

[hh_init,ww_init]=size(b_first);

nh_initial=fix(hh_init/Block_size_orderblock);
nw_initial=fix(ww_init/Block_size_orderblock);

hh_initial=[];
ww_initial=[];

for i=1:nh_initial
    for j=1:nw_initial
        hh_initial=[hh_initial i];
        ww_initial=[ww_initial j];
    end
end

for i=1:length(hh)
    text1=[text1 ']'];
    block = nw*(hh(i)-1)+ww(i);  
    text1 =[text1 num2str(block)];
end
text1=[text1 ']'];

blo_num_first=1;

c_b=1; 
ss=0;
if(isempty(ww)==1)
    fprintf('Warning: No message can be hidden in this image. Please change the cover image\n');
    disp(['Image id : ',num2str(k)]);
    continue;
else
    block_seed_counter=0;
    while (~isempty(text1) || c_b==0 )
    img=b_first((hh_initial(blo_num_first)-1)*Block_size_orderblocks+1:(hh_initial(blo_num_first)-1)*Block_size_orderblocks+Block_size_orderblocks,(ww_initial(blo_num_first)-1)*Block_size_orderblocks+1:(ww_initial(blo_num_first)-1)*Block_size_orderblocks+Block_size_orderblocks);
    img_g1=img_g((hh_initial(blo_num_first)-1)*Block_size_orderblocks+1:(hh_initial(blo_num_first)-1)*Block_size_orderblocks+Block_size_orderblocks,(ww_initial(blo_num_first)-1)*Block_size_orderblocks+1:(ww_initial(blo_num_first)-1)*Block_size_orderblocks+Block_size_orderblocks);
    [ch1, n]=MP_Generation_for_orderblocks(img_g1);
    block_seed_counter= block_seed_counter +1;
    if (nw_set == block_seed_counter)
        fprintf('Warning: Image is Simple and Smooth. Initial seeds cannot be hidden. Please change the cover image\n');
        disp(['Image id : ',num2str(k)]);
        ss = 1;
    end
    
    if(ss)
        break;
    end

    if (n~=0)
         [img, text1, c_b] = Embedding_orderblocks(ch1,text1,img);
         area11 = [area11 (hh_initial(blo_num_first)-1)*Block_size_orderblocks+1];% the location of the beginning row
         area21 = [area21 (hh_initial(blo_num_first)-1)*Block_size_orderblocks+1]; % the beginning of the first column
         area22 = [area22 (ww_initial(blo_num_first)-1)*Block_size_orderblocks+Block_size_orderblocks];     
         hh1 = [hh1 hh_initial(blo_num_first)];
         area12 = [area12 (ww_initial(blo_num_first)-1)*Block_size_orderblocks+Block_size_orderblocks];
         ww1 = [ww1 ww_initial(blo_num_first)];
         s=img_t((hh_initial(blo_num_first)-1)*Block_size_orderblocks+1:(hh_initial(blo_num_first)-1)*Block_size_orderblocks+Block_size_orderblocks,(ww_initial(blo_num_first)-1)*Block_size_orderblocks+1:(ww_initial(blo_num_first)-1)*Block_size_orderblocks+Block_size_orderblocks,1:2);
         s(:,:,3)=img;
    end
    b1_first((hh_initial(blo_num_first)-1)*Block_size_orderblocks+1:(hh_initial(blo_num_first)-1)*Block_size_orderblocks+Block_size_orderblocks,(ww_initial(blo_num_first)-1)*Block_size_orderblocks+1:(ww_initial(blo_num_first)-1)*Block_size_orderblocks+Block_size_orderblocks)=img;
    blo_num_first=blo_num_first+1;
    end
Cover_Image(:,:,3)=b1_first;
if Block_size==Block_size_orderblocks
    for i=1:length(ww)
        flag=0;
        for j=1:length(ww1)
            if(ww(i)==ww1(j)&& hh1(j)==hh(i))
                flag=1;
                ob=ob+1;
                break;
            end
        end
        if(flag==0)
            w=[w ww(i)];
            h=[h hh(i)];
        end
    end
else
    [w, h]= Eliminating_blocks_with_overlap_by_orderblocks(Cover_Image,Block_size,Block_size,Block_size_orderblocks,area11,area21,area12,area22);
end

for i=1:length(h)
    text1_temp=[text1_temp ']'];
    block = nw*(h(i)-1)+w(i);  
    text1_temp =[text1_temp num2str(block)];
end
text1_temp=[text1_temp ']'];

blo_num_first=1;

<<<<<<< HEAD
c_b=1; % counter_block
if(isempty(w)==1)
=======
c_b=1; 
if(isempty(w)==1)% in this case the valuses that certain the correspondence of the other blocks could not be hidden in the image 
>>>>>>> b23bdcb50dbaa19ba6612cf6a68cef5d9d807e23
    fprintf('Warning: No message can be hidden in this image. Please change the cover image\n');
    continue;
else
    while (~isempty(text1_temp) || c_b==0 )
    img=b_first((hh_initial(blo_num_first)-1)*Block_size_orderblocks+1:(hh_initial(blo_num_first)-1)*Block_size_orderblocks+Block_size_orderblocks,(ww_initial(blo_num_first)-1)*Block_size_orderblocks+1:(ww_initial(blo_num_first)-1)*Block_size_orderblocks+Block_size_orderblocks);
    img_g1=img_g((hh_initial(blo_num_first)-1)*Block_size_orderblocks+1:(hh_initial(blo_num_first)-1)*Block_size_orderblocks+Block_size_orderblocks,(ww_initial(blo_num_first)-1)*Block_size_orderblocks+1:(ww_initial(blo_num_first)-1)*Block_size_orderblocks+Block_size_orderblocks);
    [ch1, n]=MP_Generation_for_orderblocks(img_g1);
  
    if (n~=0)
         [img, text1_temp, c_b]=Embedding_orderblocks(ch1,text1_temp,img);
         s=img_t((hh_initial(blo_num_first)-1)*Block_size_orderblocks+1:(hh_initial(blo_num_first)-1)*Block_size_orderblocks+Block_size_orderblocks,(ww_initial(blo_num_first)-1)*Block_size_orderblocks+1:(ww_initial(blo_num_first)-1)*Block_size_orderblocks+Block_size_orderblocks,1:2);
         s(:,:,3)=img;
    end
    b1_first((hh_initial(blo_num_first)-1)*Block_size_orderblocks+1:(hh_initial(blo_num_first)-1)*Block_size_orderblocks+Block_size_orderblocks,(ww_initial(blo_num_first)-1)*Block_size_orderblocks+1:(ww_initial(blo_num_first)-1)*Block_size_orderblocks+Block_size_orderblocks)=img;
    blo_num_first=blo_num_first+1;
    end
end
Cover_Image(:,:,3)=b1_first;

text=Secret_Message;
ltxt=length(text);
img_t=Cover_Image;
b=img_t(:,:,3);
b1=img_t(:,:,3);
blo_num=1;
c_b=1;
useful_block=0;
test_work=0;

capacity = length(w); % number of blocks chosen for hidding
while ((~isempty(text) || c_b==0)&& blo_num ~=capacity+1 )
    test_work = test_work+1;
    img = b((h(blo_num)-1)*Block_size+1:(h(blo_num)-1)*Block_size+Block_size,(w(blo_num)-1)*Block_size+1:(w(blo_num)-1)*Block_size+Block_size);
    img_g2 = img_g((h(blo_num)-1)*Block_size+1:(h(blo_num)-1)*Block_size+Block_size,(w(blo_num)-1)*Block_size+1:(w(blo_num)-1)*Block_size+Block_size);
   [ch1, n] = MP_Generation(img_g2,MP_size_row,MP_size_column);
    
   if (n~=0) 
        useful_block=useful_block+1;
        old_text_size= length(text);
        [img, text, c_b] = Embedding(ch1,text,img,MP_size_row,MP_size_column);
        new_text_size= length(text);
        three_layers_of_stego_block = Cover_Image((h(blo_num)-1)*Block_size+1:(h(blo_num)-1)*Block_size+Block_size,(w(blo_num)-1)*Block_size+1:(w(blo_num)-1)*Block_size+Block_size,1:2);
        three_layers_of_stego_block(:,:,3) = img;
        block = nw*(h(blo_num)-1)+w(blo_num);
   end
    
    b1((h(blo_num)-1)*Block_size+1:(h(blo_num)-1)*Block_size+Block_size,(w(blo_num)-1)*Block_size+1:(w(blo_num)-1)*Block_size+Block_size)=img;
    blo_num = blo_num+1;
end

tEnd = toc(tStart);

if  ~isempty(text)
     numb_of_hidd_char=ltxt-length(text);
     Stego_image=Cover_Image;
     Stego_image(:,:,3)=b1;
<<<<<<< HEAD
     folder='/home/amirfarhad/Desktop/Steganography/Results/MP-capacity-128x128-3x2/not-suitable/ten-percent';
     imwrite(Stego_image,fullfile(folder,sprintf('%d_Hidden_characters_%d.ppm',k, numb_of_hidd_char)));
else
    numb_of_hidd_char = ltxt-length(text);
     Stego_image = Cover_Image;
     Stego_image(:,:,3) = b1;
     folder='/home/amirfarhad/Desktop/Steganography/Results/MP-capacity-128x128-3x2/suitable/ten-percent';
=======
     folder='Address of Folder for saving the generated Stego-image';
     imwrite(Stego_image,fullfile(folder,sprintf('%d_Hidden_characters_%d.ppm',k, numb_of_hidd_char)));
    
else %In the else part all of the secret message could not be hidden in the selected cover image.
    numb_of_hidd_char = ltxt-length(text);
     Stego_image = Cover_Image;
     Stego_image(:,:,3) = b1;
     folder='Address of Folder for saving the generated Stego-image';
>>>>>>> b23bdcb50dbaa19ba6612cf6a68cef5d9d807e23
     imwrite(Stego_image,fullfile(folder,sprintf('%d.ppm',k)));
end
end
change = sum(Cover_Image(:)~=Stego_image(:))/numel(Cover_Image);
d= [tEnd, change];
dlmwrite('Result-ten.ods',d,'-append');
end
