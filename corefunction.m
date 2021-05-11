function mfai=calmfai(b,h,t,w,a,fcuk,fc,ec,sigmaq,es)

% b、h、t、w为T型截面形状，单位为mm；a为钢筋面积，单位为mm2；fcuk为混凝土抗压强度标准值,单位为Mpa； fc为混凝土轴心抗压强度（棱柱体强度）,单位为MPa； ec为混凝土弹性模量,单位为N/mm2； sigmaq为钢筋屈服应力,单位为MPa； es为钢筋弹性模量,单位为N/mm2

tic %计算运算时间开始

clc %清屏

global stripinfo rebara H B Q F Fcuk Ec Es barstrain;

rebara=a;

H=h;Q=sigmaq;Ec=ec;B=b;Es=es;F=fc;Fcuk=fcuk;

stripinfo(1,1)=0; %计算条带信息，stripinfo(,1)为条带位置，即y；

%stripinfo(,2)为条带面积

for i=1:50

stripinfo(i+1,1)=stripinfo(i,1)+b/50;

stripinfo(i,2)=w*b/50;

end

for i=50:fix(h*50/b)

stripinfo(i+1,1)=stripinfo(i,1)+b/50;

stripinfo(i,2)=t*b/50;

end

curfai=0;

deltfai=0.0001; %角度增量

for i=1:10000

disp('step')

disp(i)

curcent(i)=calcentroid(curfai,H); %计算中性轴

fai(i)=curfai;

moment(i)=calmoment(curcent(i),curfai); %计算弯矩

maxstrain=curfai*curcent(i)*1e-3; %计算最大压应力

if maxstrain>=0.0033

disp('concrete failure') %受压区混凝土达到极限压应变，破坏

break

end

limbarstrain=Q*5/Es; %钢筋极限拉应变

if barstrain>limbarstrain

disp('reforced bar failure') %钢筋达到极限拉应力，破坏

break

end

curfai=curfai+deltfai; %角度增加

end

plot(fai,moment); %作图

xlabel('φ×1e3'),ylabel('M(N)');

hold on;

grid on;

toc %计算运行时间结束

function curcent=calcentroid(fai,h) %用二分法计算中性轴位置函数

y0=0;y2=h; %对于纯弯构件，中性轴在界面内，上下界取上下截面

y1=(y0+y2)/2;

while abs(y2-y0)/h>1e-5 %中性轴精度

f0=calaxialforce(y0,fai); %计算轴力

f1=calaxialforce(y1,fai);

f2=calaxialforce(y2,fai);

if f0*f1>=0 & f1*f2<=0

y0=y1;

y1=(y0+y2)/2;

end

if f0*f1<=0 & f1*f2>=0

y2=y1;

y1=(y0+y2)/2;

end

end

curcent=(y0+y2)/2;

function axialforce=calaxialforce(y,fai) %计算轴力函数

global stripinfo rebara B H Ec barstrain stripforce;

conforce=0;

for i=1:fix(H*50/B)

stripstrain(i)=(y-stripinfo(i,1))*fai*1e-3; %计算条带应变

if stripstrain(i)<=-0.0001

break

end

if stripstrain(i)>=0

stripstress=calstress(stripstrain(i)); %计算条带应力

end

if stripstrain(i)<0&stripstrain(i)>=-0.0001

stripstress=stripstrain(i)*Ec;

end

stripforce(i)=stripstress*stripinfo(i,2);

conforce=stripforce(i)+conforce;%对条带轴力进行叠加

end

barstrain=fai*(H-y-20)*1e-3; %钢筋应变，保护层厚度为20mm

rebarstress=calrebarstress(barstrain); %钢筋应力

axialforce=conforce-rebara*rebarstress; %总轴力

function stress=calstress(strain) %根据混凝土本构关系计算混凝土压应力函数

global F Fcuk;

if Fcuk>=50

n=2-1/60*(Fcuk-50);

else Fcuk=50;n=2;

end

ypsl=0.002+0.5*(Fcuk-50)*1e-5;

if strain<=ypsl

stress=F*(1-(1-strain/ypsl)^n);

end

if strain>ypsl

stress=F;

end

function calrebarstress=calrebarstress(barsrtain) %计算钢筋应力

global Es Q;

calrebarstress=barsrtain*Es;

if calrebarstress>Q

calrebarstress=Es/100*(barsrtain-Q/Es)+Q;

end

function moment=calmoment(y,fai) %计算弯矩函数

conmoment=0;

global stripinfo H rebara B stripforce Ec;

for i=1:fix(y*50/B)

conmoment=conmoment+stripforce(i)*(y-stripinfo(i,1));

end

tenmoment=0;

for i=fix(y*50/B):fix(H*50/B)

tenstrain=(stripinfo(i,1)-y)*fai*1e-3;

if tenstrain>0.0001

break

end

tenstress=tenstrain*Ec;

tenmoment=tenmoment-stripforce(i)*(stripinfo(i,1)-y);

%受拉区混凝土提供弯矩

end

barstrain=fai*(H-y-20)*1e-3;

barmoment=rebara*calrebarstress(barstrain)*(H-y-20); %钢筋提供弯矩

moment=conmoment+barmoment+tenmoment;