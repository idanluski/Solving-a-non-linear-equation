%ID's
format long
I_1  = 209203751;
I_2  = 207691262;
S = 3^(1/4);
%initial the domain
a = 3^(1/6);
b= 5;

x_n = a + (I_1/(I_1 + I_2))*(b - a); %x_0

error = 10^(-12);


%array itiates
x_n_arr = [x_n];
sequence = [0];
relative_error = [0];
cur = f(x_n);
iteration = [0];

%for q1,C
error_n = [];
error_n_perv = [];

%iteration number
i = 0;

while(cur >= error)
%till get to 12 digits stable
error_n_perv = [error_n_perv, abs(x_n - S)];
 
%calculate next
x_next = x_n - (f(x_n)/f_prime(x_n)); 

%calculate data  
x_n_arr = [ x_n_arr, x_next];
sequence = [sequence, abs(x_n - x_next)];

cur = abs(x_n - S);
relative_error = [relative_error, cur];

x_n = x_next;
i= i+1;
iteration = [iteration , i];




end
   

T = table(iteration',x_n_arr', sequence', relative_error' , 'VariableNames',{'iteration number:','x_n','|x_n - x_n_next|', ' relative error'});
disp(T)


%ploting 
figure('Name','newton raphson: 0 = x^4 - 3');
title('newton raphson: 0 = x^4 - 3')
rl = relative_error(1,2:end-1);
er =error_n_perv(1,2:end);
plt = plot(log(rl),log(er),'--o');
grid on
title("log{\epsilon_n} in finction of log{\epsilon_{n-1}} ")
xlabel("\epsilon_{n-1}")
ylabel("\epsilon_n")


%function making

function f = f(x)
    f = x^4 - 3;
end

function f = f_prime(x)
    f = 4*x^3;
end

