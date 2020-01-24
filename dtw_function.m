function [min_distance, d, g, path] = dtw(A, B, adjustment_window_size)
r = adjustment_window_size;

% get length of speech patterns A and B
[~, I] = size(A);
[~, J] = size(B);

% local distance matrix
d = zeros(I, J);
A(:,1)=0;
A(:,2)=0;
A(:,3)=0;
A(:,4)=0;
A(:,5)=0;
A(:,6)=0;
A(:,7)=0;
A(:,8)=0;
A(:,9)=0;
B(:,1)=0;
B(:,2)=0;
B(:,3)=0;
B(:,4)=0;
B(:,5)=0;
B(:,6)=0;
B(:,7)=0;
B(:,8)=0;
B(:,9)=0;

for i = 1:I
    for j = 1:J
        feature_distances = A(:,i)-B(:,j);
        distance = sqrt(sum(feature_distances.^2));
        d(i,j) = distance;
    end
end

% global distance matrix
g = zeros(I+1,J+1);
g(:,:) = inf;
g(1,1) = 2*d(1,1); % initial condition, see (19) in [SakoeChiba1978]
s = J/I; % slope from (0,0) to (I,J)
steps = zeros(I,J); % steps to take in order to reach D(i,j)

for i = 2:I+1;
    for j = 2:J+1;
        if (abs(i-(j/s)) > r)
            % we're outside the adjustment window
            continue;
        end

        % local distance matrix is smaller than g, translate coordinates
        i_l = i-1;
        j_l = j-1;

        % calculate global distances
        % (see DP-equation (20) from [SakoeChiba1978] for reference)
        [distance, step] =  min([g(i,   j-1) +   d(i_l, j_l)...
                                 g(i-1, j-1) + 2*d(i_l, j_l)...
                                 g(i-1, j)   +   d(i_l, j_l)]);
        g(i,j) = distance;
        steps(i-1,j-1) = step;
    end
end

% time normalize global distance matrix
N=I+J;
D=g/N;

% remove additional inf padded row and column from global distance matrix
D=D(2:end,2:end);

% path=traceback_path(steps);

min_distance = D(end, end);
