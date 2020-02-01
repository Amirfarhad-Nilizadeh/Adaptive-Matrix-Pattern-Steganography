function intens=Intensity(img)
red=img(:,:,1);
green=img(:,:,2);
blue=img(:,:,3);
intens=uint8((double(red)+double(green)+double(blue))/3);
end