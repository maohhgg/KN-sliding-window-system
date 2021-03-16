
% this function get element availability

% EA=ElementAvailability
function EA=GetEA(n,tp,ST,T,T_ind,tm,lamda)
    EA=zeros(1,n); 
    for i=1:n
        EA(i)=1-tp(i)*(ST/T(T_ind(i))-1)/ST-tm(i)*lamda(i,T_ind(i))/T(T_ind(i));
    end
end
