%ID's
format long
I_1  = 209203751;
I_2  = 207691262;
%root s
S = 3^(1/4);
a = 3^(1/6);
b= 5;

x_perv = a + (I_1/(I_1 + I_2))*(b - a); %x_0
x_n = x_perv + (I_1/(I_1 + I_2))*(b - x_perv); %x_1
error = 10^(-12);

%array itiates
x_n_arr = [x_n];
sequence = [0];
relative_error = [0];
cur = 100;
iteration = [0];

%for q1,C
error_n = [];
error_n_perv = [];

%iteration number
i = 0;

while(cur >= error)

error_n_perv = [error_n_perv, abs(x_n - S)];
 
%calculate next
x_next = x_n - f(x_n)*((x_n-x_perv)/(f(x_n)-f(x_perv))); 

%calculate data
x_n_arr = [ x_n_arr, x_next];
sequence = [sequence, abs(x_n - x_next)];

cur = abs(x_n - S);
relative_error = [relative_error, cur];
x_perv = x_n;
x_n = x_next;
i= i+1;
iteration = [iteration , i];




end
   
%making table
T = table(iteration',x_n_arr', sequence', relative_error' , 'VariableNames',{'iteration number:','x_n','|x_n - x_n_next|', ' relative error'});
disp(T)


%plotting
figure('Name','Secant method: 0 = x^4 - 3');
title('Secant method: 0 = x^4 - 3')
rl = relative_error(1,2:end-1);
er = error_n_perv(1,2:end);
plt = plot(log(rl),log(er),'--o');
title("Q2: log{\epsilon_n} in finction of log{\epsilon_{n-1}} Secant method ")
xlabel("\epsilon_{n-1}")
ylabel("\epsilon_n")
grid on


function f = f(x)
    f = x^4 - 3;
end

function f = f_prime(x)
    f = 4*x^3;
end




