function code = train(traindir, n)
k = 16;                         % number of centroids required
for i=1:n                       % train a VQ codebook for each speaker
    file = sprintf('%s%d.mp3', traindir, i);           
    disp(file);
   
    [s, fs] = audioread(file);
    
    v = mfcc(s, fs);            % Compute MFCC's
    
    code{i} = dtw_in(v, k);      % Train VQ codebook
end