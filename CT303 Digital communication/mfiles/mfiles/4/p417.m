t = linspace(0, 3, 1000);
a = zeros(size(t));
a(t >= 0 & t < 1.5) = t(t >= 0 & t < 1.5);
a(t >= 1.5 & t <= 3) = -t(t >= 1.5 & t <= 3) + 3;
[sqnr18,aquan18,code18]=u_pcm(a,8);
[sqnr28,aquan28,code28]=u_pcm(a,8);
[sqnr16,aquan16,code16]=u_pcm(a,16);
[sqnr26,aquan26,code26]=u_pcm(a,16);
subplot(2,2,1);
plot(t,aquan18,' - ',t,zeros(1,length(t)))
title("For 8 level PCM quantized signal");
subplot(2,2,2);
plot(t,a-aquan28,' - ',t,zeros(1,length(t)))
title("For 8 level PCM quantized error signal");
subplot(2,2,3);
plot(t,aquan26,' - ',t,zeros(1,length(t)))
title("For 16 level PCM quantized signal");
subplot(2,2,4);
plot(t,a-aquan26,' - ',t,zeros(1,length(t)))
title("For 16 level PCM quantized error signal");
sqnr18
sqnr16
function [ sqnr, a_quan,code ]=u_pcm( a,n)
amax=max(abs(a));
a_quan=a/amax;
b_quan=a_quan;
d=2/n;
q=d.*[0:n-1];
q=q-((n-1 )/2) *d;
for i=1 :n
a_quan(find((q(i)-d/2 <= a_quan) & (a_quan <= q(i)+d/2)))= ...
q(i).*ones(1,length(find((q(i)-d/2 <= a_quan) & (a_quan <= q(i)+d/2))));
b_quan(find( a_quan==q(i) ))=(i-1 ).*ones(1,length(find( a_quan==q(i) )));
end
a_quan=a_quan * amax;
nu=ceil(log2(n));
code=zeros(length(a),nu);
for i=1 :length(a)
for j=nu:-1 :0
if ( fix(b_quan(i)/(2 ^j)) == 1)
code(i,(nu-j)) = 1;
b_quan(i) = b_quan(i) - 2^j;
end
end
end

sqnr=20*log10(norm(a)/norm(a-a_quan));
end