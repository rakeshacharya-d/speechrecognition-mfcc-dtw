function test(testdir, n, code)

for k=1:n                       % read test sound file of each speaker
    file = sprintf('%s%d.mp3', testdir, k);
    [s, fs] = audioread(file);      
        
    v = mfcc(s, fs);            % Compute MFCC's
   
    distmin = inf;
    k1 = 0;
   
    for l = 1:length(code)      % each trained codebook, compute distortion
        d = distance(v, code{l});
        d(1,:)=0;
        d(2,:)=0;
        d(3,:)=0;
        d(4,:)=0;
        d(5,:)=0;
        d(6,:)=0;
        d(7,:)=0;
        d(8,:)=0;
        d(9,:)=0;
        dist = sum(min(d,[],2)) / size(d,1);
      
        if dist < distmin
            distmin = dist;
            k1 = l;
            
        end      
    end
%     a=sprintf('%d %d %d',distmin,dist,k1);
%     disp(a);
    p=sprintf('%d %d',dist,distmin);
    msg = sprintf('Speaker %d matches with Speaker %d', k, k1);
    disp(msg);
   
end