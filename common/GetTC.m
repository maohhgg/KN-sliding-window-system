% this function get element availability
% EA=ElementAvailability
function TC=GetTC(n,ST,T,T_ind,lamda,cp,cm)
    %TC=Total Cost
    TC=0;
    for i=1:n
        TC=TC+cp(i)*(ST/T(T_ind(i))-1)+cm(i)*lamda(i,T_ind(i))*(ST/T(T_ind(i)));
    end
end