N = 256;
s = cell(1,N);
for i=1:N
    s{i} = char(i);
end

numRands = length(s);
%specify length of random string to generate
sLength = 3277; %10 percent of image
%generate random string
randString = s( ceil(rand(1,sLength)*numRands));
ltxt=length(randString);


fid = fopen('random.txt','wt');
for rows = 1:size(randString,1)
fprintf(fid,'%s',randString{rows,:});
end
fclose(fid);
