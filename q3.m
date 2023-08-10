%ID's
format long

%ID
I_1  = 209203751;
I_2  = 207691262;
a = 3^(1/6);
b= 5;
x_n = 5; %x_0
error = 10^(-12);

 
[T,relative_error,error_n_perv] = newton_rapson(@f,@f_prime,error,x_n,1);
newNames = {' f(x) iteration number:','f(x) x_n','f(x) |x_n - x_n_next|', 'f(x) relative error'};
% Change the column names
T.Properties.VariableNames = newNames;
disp("section A")
disp(T)






%plotting

figure('Name',"NR0");
rl = relative_error;
er =error_n_perv;
plt = plot(log(rl),log(er),'--o');
title('NR0 (Newton - Raphson)');
xlabel("\epsilon_{n-1}")
ylabel("\epsilon_{n}")
grid on

%making table using newton_raphson
[T_2,relative_error_2,error_n_perv_2] = newton_rapson(@U,@U_prime,error,x_n,1);

disp("table 2");
disp(T_2);


% Create the UI table
% Define new column names
newNames = {' U(x) iteration number:','U(x) x_n','U(x) |x_n - x_n_next|', 'U(x) relative error'};
% Change the column names
T_2.Properties.VariableNames = newNames;
% Combine the tables side by side
combinedTable = horzcat(T, T_2);

disp(combinedTable);


%plotting
figure('Name',"NR1");
rl = relative_error_2;
er =error_n_perv_2;
plt = plot(log(er),log(rl),'--o');
title('Q3:NR1 (Newton - Raphson)');

xlabel("\epsilon_{n-1}")
ylabel("\epsilon_{n}")
grid on
%i calculate q with this package but im not sure if its install on youc computer so the q = 3 
%syms x
%q = 1/ limit(U(x)  /(x-2),x,2);
q = 3 
disp(q);


%making table using newton raphson method
[T_3,relative_error_3,error_n_perv_3] = newton_rapson(@f,@f_prime,error,x_n,q); %P = q
disp(T_3);
figure('Name',"NR2");
rl = relative_error_3;
er =error_n_perv_3;
plt = plot(log(er),log(rl),'--o');
title('NR2 (Newton - Raphson)');
xlabel("\epsilon_{n-1}")
ylabel("\epsilon_{n}")
grid on

newNames_2 = {'P=3 U(x) iteration number:',' P=3 U(x) x_n','P=3 U(x) |x_n - x_n_next|', 'P=3 U(x) relative error'};
% Change the column names
T_3.Properties.VariableNames = newNames_2;

combinedTable_2 = horzcat(combinedTable,T_3);

disp(combinedTable_2);

function [T,relative_error,error_n_perv] = newton_rapson(g,g_prime,error,x_n,P)
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
[S,N] = find_S(0,x_n,error);
cur = abs(x_n - S);
cur_1 =0;
while(cur >= error   )


 
%calculate next
x_next = x_n - P*g(x_n)/g_prime(x_n); 

%calculate data
x_n_arr(i+1) = x_next;
sequence(i+1) = abs(x_n - x_next);

cur_1 = abs(x_next - S); 
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


T = table(iteration,x_n_arr, sequence, relative_error , 'VariableNames',{'iteration number:','x_n','|x_n - x_n_next|', ' relative error'});
end

function f = f(x)
    f = (x^5-6*x^4+14*x^3-20*x^2+24*x-16);
end

function f = ffprime(x)
    f = (x^5-6*x^4+14*x^3-20*x^2+24*x-16)/(5*x^4-24*x^3+42*x^2-40*x+24);
end




function f = f_prime_prime(x)
    f = 40*x^3-72*x^2+44*x-40;
end

function f = f_prime(x)
    f = 5*x^4-24*x^3+42*x^2-40*x+24;
end

function u = U(x)
    u = (x^5-6*x^4+14*x^3-20*x^2+24*x-16)/(5*x^4-24*x^3+42*x^2-40*x+24);
end

function ut = U_prime(x)
ut =1-((20*x^3-72*x^2+84*x-40)/(5*x^4-24*x^3+42*x^2-40*x+24))*U(x);
end


function u = uuprime(x)
u = U(x)/U_prime(x);
end



function [s,N] = find_S(i,x_n,error)
cur = 100;
while(cur >= error)
%calculate next
x_next = x_n - (f(x_n)/f_prime(x_n)); 

cur = x_n - x_next;
x_n = x_next;
i= i+1;

end

s = x_next;
N = i;
end
