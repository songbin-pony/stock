clear
clc
%************************************************
%             截面的形状
%************************************************
width=240;height=500;%单位mm
figure(1)
line([0 width width 0 0],[0 0 height height 0],'linewidth',3)
axis([-100,400,-100,500])
title('the shape of the section','visible','on','color','b');
 
%************************************************
%             条分法分块计算每块面积
%************************************************
%N=input('请输入条带法中分条数目N（例如250）：');%分块个数
N=2000;
H=height;%梁高
W=width;%梁宽
for i=1:N
    A(i)=H/N*W;
end
Ac=H*W;
disp('---------------------------');
disp(['****截面高度为',num2str(H/1000),'m']);
disp(['****截面面积为',num2str(Ac/1000000),'m^2']);
disp('---------------------------');
A=fliplr(A);
 
%************************************************
%             计算主程序
%************************************************
%基本参数设置
disp('请输入基本参数！！！')
% fcuk=input('请输入混凝土标号（例如C40输入40）：');%混凝土立方体抗压强度标准值（MPa）
% steeltype=input('请输入钢筋类型（1-HPB300 2-HRB335 3-HRB400 4-RRB400）（例如HRB335钢筋请输入2）：');%钢筋抗拉强度
% As=input('请输入钢筋面积（mm^2）（面积为一个向量，例如[10000 20000]）：');%钢筋面积（mm^2)
% dsteel=input('请输入钢筋到下边缘的距离（mm）（距离为一个向量，和面积相对应，例如[30 1970]）：');%钢筋保护层厚度（mm）
 fcuk=30;steeltype=1;As=[1018 0];dsteel=[45 500];
%************************************************
%             应力应变关系图
%************************************************
cu=0.0033;%混凝土极限压应变
sk=0.01;%钢筋极限拉应变
for i=1:1000
    cs(i)=cu/1000*i;
    cstress(i)=concretestress(cs(i),fcuk);
end
figure(3)
plot(cs,cstress,'-','linewidth',2)       %画混凝土应力应变关系图
xlabel('应变strain')
ylabel('应力stress(MPa)')
grid on
title('混凝土应力应变关系图'); 
for i=1:1000
    ts(i)=sk/1000*i;
    tstress(i)=steelstress(ts(i),steeltype);
end
figure(4)
plot(ts,tstress,'-','linewidth',2)       %钢筋应力应变关系图
ylabel('应力stress(MPa)')
axis([0,0.015,0,400])
grid on
title('钢筋应力应变关系图');
%************************************************
%             迭代部分
%************************************************
for i=1:100
    strain=0.005/100*i;
    kmin=(H-dsteel(2))/H;
    kmax=(H-dsteel(1))/H;
    for j=1:100
        k(j)=(kmax-kmin)/100*j;
        y0(j)=H-k(j)*H;
        fai(j)=strain/(k(j)*H);
        N(j)=axialforce(fai(j),y0(j),A,H,fcuk,steeltype,As,dsteel)
    end
   strain_save(i)=strain;
   save_N(i)=min(abs(N));
   index=find(abs(N)==min(min(abs(N))));
   save_fai(i)=fai(index);
   save_k(i)=k(index);
   save_y0(i)=H-save_k(i)*H;
   M_save(i)=moment(save_fai(i),save_y0(i),A,H,fcuk,steeltype,As,dsteel);
   down_ts_save(i)=save_fai(i)*(save_y0(i)-dsteel(1));%仅仅考虑受拉钢筋的应变
   up_ts_save(i)=save_fai(i)*( save_k(i)*H+dsteel(2)-H)
   if (down_ts_save(i)>sk)
       break;
   end   
end
%输出部分
figure(5)
plot(save_fai,M_save,'-','linewidth',2)       %钢筋应力应变关系图
ylabel('弯矩(N.mm)')
grid on
title('弯矩曲率图');

step=size(strain_save);
for i=1:step(2)
    stestress(i)=steelstress(down_ts_save(i),steeltype);
end
figure(6)
plot(stestress,M_save,'-','linewidth',2)       %钢筋应力应变关系图
ylabel('弯矩(N.mm)')
grid on
title('弯矩与受拉钢筋应力图');


step=size(strain_save);
for i=1:step(2)
    constress(i)=concretestress(strain_save(i),fcuk);
end
    
figure(7)
plot(constress,M_save,'-','linewidth',2);
ylabel('弯矩(N.mm)')
grid on
title('弯矩与受压边缘混凝土应力图');

%2）钢筋应力函数
function gs=steelstress(ts,steeltype)
canshu=[250 300 330 360;210000 200000 200000 200000;];
fy=canshu(1,steeltype);
Es=canshu(2,steeltype);
ts0=fy/Es;
if ts<=ts0
    gs=Es*ts;
else
    gs=fy;
end
end
%3）混凝土应力函数
function hc=concretestress(cs,fcuk)  
 canshu=[15 20 25 30 35 40 45 50 55 60 65 70 75 80;
7.2 9.6 11.9 13.8 16.7 19.1 21.1 23.1 25.3 27.5 29.7 31.8 33.8 35.9;
22000 25500 28000 30000 31500 32500 33500 34500 35500 36000 36500 37000 37500 38000;];
[mm,nn]=size(canshu);
for i=1:nn
    if fcuk==canshu(1,i)
        fc=canshu(2,i);
        Ec=canshu(3,i);
    end
end
n=2-(fcuk-50)/60;n=min(n,2);
cs0=0.002+0.5*(fcuk-50)/100000;cs0=max(cs0,0.002);
 
if cs<=cs0&&cs>=0
    hc=fc*(1-(1-cs/cs0)^n);
else if cs>cs0&&cs<0.0033
    hc=fc;
 else             %记混凝土受拉时应力为0
        hc=0;
    end
end

 
 
% cscu=0.0033-(fcuk-50)/100000;cscu=min(cscu,0.0033);
% if cs<=cs0&&cs>=0
%     hc=fc*(1-(1-cs/cs0)^n);
% else if cs>cs0&cs<=cscu
%     hc=fc;
%     else if cs>cscu
%             error('混凝土的应变值太大');
%         else             %记混凝土受拉时应力为0
%             hc=0;
%         end
%     end
% end
end
%4）轴力计算函数

function N=axialforce(fai,y0,A,h,fcuk,steeltype,As,dsteel)
          %m为T形截面翼缘条带数，n为T形截面翼缘一下矩形截面条带数
Nc=0;
m=length(A);
for i=1:m
    csi=fai*(h/m*(i-0.5)-y0);   %翼缘每一条带中心混凝土的应变
    hci=concretestress(csi,fcuk);
    Nc=Nc+hci*A(i);
end
Ns=0;
n=length(As);
for i=1:n
    ts=fai*(y0-dsteel(i)); %钢筋应变
    gs=steelstress(abs(ts),steeltype);
    Ns=Ns+gs*As(i)*sign(ts);
end
N=Nc-Ns;
end
%5）弯矩计算函数
function M=moment(fai,y0,A,h,fcuk,steeltype,As,dsteel)   
      
Mc=0;
m=length(A);
for i=1:m
    csi=fai*(h/m*(i-0.5)-y0);   %翼缘每一条带中心混凝土的应变
    hci=concretestress(csi,fcuk);
    Mc=Mc+hci*A(i)*(h/m*(i-0.5)-y0);
end
Ms=0;
n=length(As);
for i=1:n
    ts=fai*(y0-dsteel(i)); %钢筋应变
    gs=steelstress(abs(ts),steeltype);
    Ms=Ms+gs*As(i)*abs(y0-dsteel(i));
end
M=Mc+Ms;
end
%6）中性轴计算函数
function [y0] = Calaxis(A,h)
%计算中和轴，y0为中和轴到截面底端的距离
m=length(A);
y1=0;
y2=h;
while(y2-y1>0.00000001)    
    
    N1=0;
    N2=0;
    for i=1:m
        N1=N1+A(i)*(h/m*(i-0.5)-y1);
        N2=N2+A(i)*(h/m*(i-0.5)-y2);
    end
    y0=(y1+y2)/2;
    N0=0;
    for i=1:m
        N0=N0+A(i)*(h/m*(i-0.5)-y0);
    end
    if N0==0
        break
    else if N0*N1>0
            y1=y0;
        else
            y2=y0;
        end
    end
end
end

