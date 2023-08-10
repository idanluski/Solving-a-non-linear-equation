%ID's
format long

%ID
I_1  = 209203751;
I_2  = 207691262;

x_n = pi/2; %x_0
error = 10^(-12);


%makig table of point using fixed point method
[T_1,relative_error,error_n_perv] = fixed_point(@g,error,x_n);


%ploting graph
disp(T_1);
figure('Name','fixed point: 0 = x-2*sin(x)');
title('fixed point: 0 = x-2*sin(x) , g(x) = 2sin(x)')
rl = relative_error(1,2:end-1);
er =error_n_perv(1,2:end);
plt = plot(log(rl),log(er),'--o');
title('fixed point');
xlabel("\epsilon_{n-1}")
ylabel("\epsilon_n")
grid on

%after finding s from section1
s = 1.895494267034;
x_n = pi/2; %x_0

%making table with data using newton raphson method
[T,relative_error,error_n_perv] = newton_rapson(@f,@f_prime,error,x_n,1,s);



%plotting NR graph
figure('Name',"NR");
rl = relative_error;
er =error_n_perv;
plt = plot(log(er),log(rl),'--o');
title('NR (Newton - Raphson)');
disp(T);
xlabel("\epsilon_{n-1}")
ylabel("\epsilon_n")
grid on


x_n = 1; %x_0
%finding table and s using  fived pont on g function
[T_2,relative_error,error_n_perv] = fixed_point(@g_1,error,x_n);


%plotting
disp(T_2);
figure('Name','fixed point: g(x) = arcsin(x/2)');

rl = relative_error(1,2:end-1);
er =error_n_perv(1,2:end);
plt = plot(log(er),log(rl),'--o');
title('fixed point: 0 = x-2*sin(x)   , g(x) = arcsin(x/2)')
xlabel("\epsilon_{n-1}")
ylabel("\epsilon_{n}")
grid on


function [s,N] = find_S(i,x_n,error,g)
%finding the root with fixed point
cur = 100;
while(cur >= error)
%calculate next
x_next = g(x_n); 

cur = abs(x_next- x_n);
x_n = x_next;
i= i+1;

end

s = x_next;
N = i;
end


function g = g(x)
%g(x) function
    g = 2*sin(x) ;
end

function f = f(x)
%f(x) function
    f = x - 2.*sin(x) ;
end

function f = f_prime(x)
% f' = df/dx 
    f = 1 - 2*cos(x) ;
end

function [T,relative_error,error_n_perv] = newton_rapson(g,g_prime,error,x_n,P,S)
%newton raphson method get function and his derivative,start point, and s

%array itiates
x_n_arr = zeros(50,1);
x_n_arr(1) = x_n;
sequence = zeros(50,1);
relative_error = zeros(50,1);

iteration = zeros(50,1);

%for q1,C
error_n = zeros(1,50);
error_n_perv = zeros(1,50);

%iteration number
i = 0;
cur = abs(x_n - S);
cur_1 =0;
while(cur >= error   )


 
%calculate next
x_next = x_n - P*g(x_n)/g_prime(x_n); 

%calculate data
x_n_arr(i+1) = x_next;
sequence(i+1) = abs(x_n - x_next);

cur_1 = abs(x_next - S); %calculate error

if (cur_1-cur>0)
    break
end
error_n_perv(i+1) = cur;
relative_error(i+1) = cur_1;
cur = cur_1;

x_n = x_next;
i= i+1;
iteration(i+1) = i;

end
%making a table
T = table(iteration,x_n_arr, sequence, relative_error , 'VariableNames',{'iteration number:','x_n','|x_n - x_n_next|', ' relative error'});
end


function [T,relative_error,error_n_perv] = fixed_point(F,error,x_n)
%array itiates
x_n_arr = [x_n];
sequence = [0];
relative_error = [0];
cur = g(x_n);
iteration = [0];

%for q1,C
error_n = [];
error_n_perv = [];

%iteration number
i = 0;

[S,N] = find_S(i,x_n,error,F);
while(cur > error)

error_n_perv = [error_n_perv, abs(x_n - S)];
 
%calculate next
x_next = F(x_n); 

%calculate data
x_n_arr = [ x_n_arr, x_next];
sequence = [sequence, abs(x_n - x_next)];

cur = abs(x_n - S);
relative_error = [relative_error, cur];

x_n = x_next;
i= i+1;
iteration = [iteration , i];




end
   
%making a table
T = table(iteration',x_n_arr', sequence', relative_error' , 'VariableNames',{'iteration number:','x_n','|x_n - x_n_next|', ' relative error'});
disp(T)

end


function g =g_1(x)
g = asin(x/2); 
end