% Coefficient matrix A
A = [2, 3, 4;
     1, 5, 2;
    2, 4, 3];

% Right-hand side vector b
b = [1; 8; 4];
help=[0; 0; 1];

% Add slack and surplus variables
constraints = size(A, 1);
variables = size(A, 2);

% Construct augmented matrix
aug_mat = [A, eye(constraints), b];

% Print augmented matrix table
fprintf('Augmented Matrix:\n');
fprintf('-----------------------------------------------------------------------------------\n');
% fprintf(' Basis | ');
for i = 1:variables
    fprintf('    x%d    |', i);
end
for i = 1:constraints
    fprintf('    s%d    |', i);
end
fprintf('    b\n');
fprintf('-----------------------------------------------------------------------------------\n');

i=find(help>0);
aug_mat(i,constraints+i)=-1;

for i = 1:size(aug_mat,1)
    for j = 1:size(aug_mat,2)
        fprintf('%10.2f|', aug_mat(i, j));
    end
    fprintf('\n');
end
