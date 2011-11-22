% Kelvin Zhang, Arvind Ganesh, February 2011. 
% Questions? zhangzdfaint@gmail.com, abalasu2@illinois.edu
%
% Copyright: Perception and Decision Laboratory, University of Illinois, Urbana-Champaign
%            Microsoft Research Asia, Beijing
%
% Reference: TILT: Transform Invariant Low-rank Textures  
%            Zhengdong Zhang, Xiao Liang, Arvind Ganesh, and Yi Ma. Proc. of ACCV, 2010.
%

function S=constraints(tau, XData, YData, mode)
% constraints() will get the linearize constraints of tau according to
% mode.
% -----------------------------input--------------------------------------
% tau:          p-by-1 real vector.
% mode:         one of 'euclidean', 'euclidean_notranslation', 'affine', 'affine_notranslation', 'homography',
%               'homography_notranslation'.
% ----------------------------output--------------------------------------
% S:            linearized constraints on tau.
switch lower(mode)
    case 'euclidean'
        S=zeros(2, 3);
    case 'euclidean_notranslation'
        S=zeros(2, 1);
    case 'affine'
        S=zeros(2, 6);
        vec1=[tau(1); tau(4)];
        vec2=[tau(2); tau(5)];
        V=sqrt(norm(vec1)^2*norm(vec2)^2-(vec1'*vec2)^2);
        S(1, 1)=(tau(1)*norm(vec2)^2-vec1'*vec2*tau(2))/V;
        S(1, 2)=(tau(2)*norm(vec1)^2-vec1'*vec2*tau(1))/V;
        S(1, 4)=(tau(4)*norm(vec2)^2-vec1'*vec2*tau(5))/V;
        S(1, 5)=(tau(5)*norm(vec1)^2-vec1'*vec2*tau(4))/V;
        S(2, 1)=2*tau(1);
        S(2, 2)=-2*tau(2);
        S(2, 4)=2*tau(4);
        S(2, 5)=-2*tau(5);
    case 'affine_notranslation'
        S=zeros(2, 4);
        vec1=[tau(1);tau(3)];
        vec2=[tau(2);tau(4)];
        V=sqrt(norm(vec1)^2*norm(vec2)^2-(vec1'*vec2)^2);
        S(1, 1)=(tau(1)*norm(vec2)^2-vec1'*vec2*tau(2))/V;
        S(1, 2)=(tau(2)*norm(vec1)^2-vec1'*vec2*tau(1))/V;
        S(1, 3)=(tau(3)*norm(vec2)^2-vec1'*vec2*tau(4))/V;
        S(1, 4)=(tau(4)*norm(vec1)^2-vec1'*vec2*tau(3))/V;
        S(2, 1)=2*tau(1);
        S(2, 2)=-2*tau(2);
        S(2, 3)=2*tau(3);
        S(2, 4)=-2*tau(4);
    case 'homography'
%         S=zeros(2, 8);
%         vec1=[tau(1); tau(4)];
%         vec2=[tau(2); tau(5)];
%         V=sqrt(norm(vec1)^2*norm(vec2)^2-(vec1'*vec2)^2);
%         S(1, 1)=(tau(1)*norm(vec2)^2-vec1'*vec2*tau(2))/V;
%         S(1, 2)=(tau(2)*norm(vec1)^2-vec1'*vec2*tau(1))/V;
%         S(1, 4)=(tau(4)*norm(vec2)^2-vec1'*vec2*tau(5))/V;
%         S(1, 5)=(tau(5)*norm(vec1)^2-vec1'*vec2*tau(4))/V;
%         S(2, 1)=2*tau(1);
%         S(2, 2)=-2*tau(2);
%         S(2, 4)=2*tau(4);
%         S(2, 5)=-2*tau(5);
        S=zeros(0, 8);
    case {'homography_special', 'homography_special_notranslation'}
%         S=zeros(0, 8);
        S=zeros(1, 8);
        temp=reshape(tau, 2, 4);
        X=temp(1, :);
        Y=temp(2, :);
        e1=[X(3)-X(1); Y(3)-Y(1)];
        e2=[X(4)-X(2); Y(4)-Y(2)];
        norm_e1=e1'*e1;
        norm_e2=e2'*e2;
        e1e2=e1'*e2;
        N=2*sqrt(norm_e1*norm_e2-e1e2^2);
        S(1, 1)=1/N*(2*(X(3)-X(1))*(-1)*norm_e2-2*e1e2*(-1)*(X(4)-X(2)));
        S(1, 2)=1/N*(2*(Y(3)-Y(1))*(-1)*norm_e2-2*e1e2*(-1)*(Y(4)-Y(2)));
        S(1, 3)=1/N*(2*(X(4)-X(2))*(-1)*norm_e1-2*e1e2*(-1)*(X(3)-X(1)));
        S(1, 4)=1/N*(2*(Y(4)-Y(2))*(-1)*norm_e1-2*e1e2*(-1)*(Y(3)-Y(1)));
        S(1, 5)=1/N*(2*(X(3)-X(1))*norm_e2-2*e1e2*(X(4)-X(2)));
        S(1, 6)=1/N*(2*(Y(3)-Y(1))*norm_e2-2*e1e2*(Y(4)-Y(2)));
        S(1, 7)=1/N*(2*(X(4)-X(2))*norm_e1-2*e1e2*(X(3)-X(1)));
        S(1, 8)=1/N*(2*(Y(4)-Y(2))*norm_e1-2*e1e2*(Y(3)-Y(1)));
%         S(2, 1)=2*(X(2)-X(1))*(-1)-2*(X(1)-X(4));
%         S(2, 2)=2*(Y(2)-Y(1))*(-1)-2*(Y(1)-Y(4));
%         S(2, 3)=2*(X(2)-X(1))-2*(X(3)-X(2))*(-1);
%         S(2, 4)=2*(Y(2)-Y(1))-2*(Y(3)-Y(2))*(-1);
%         S(2, 5)=2*(X(4)-X(3))*(-1)-2*(X(3)-X(2));
%         S(2, 6)=2*(Y(4)-Y(3))*(-1)-2*(Y(3)-Y(2));
%         S(2, 7)=2*(X(4)-X(3))-2*(X(1)-X(4))*(-1);
%         S(2, 8)=2*(Y(4)-Y(3))-2*(Y(1)-Y(4))*(-1);
    case 'homography_notranslation'
        S=zeros(0, 8);
%         H=eye(3);
%         H(1, 1:2)=tau(1:2);
%         H(2, 1:2)=tau(3:4);
%         H(3, 1:2)=tau(5:6);
%         X0=[XData(1) XData(2) XData(2) XData(1)];
%         Y0=[YData(1) YData(1) YData(2) YData(2)];
%         pt=H*[X0; Y0; ones(1, 4)];
%         N1=pt(1, :);
%         N2=pt(2, :);
%         N=pt(3, :);
%         X=N1./N;
%         Y=N2./N;
%         dXdH=zeros(4, 6);
%         dYdH=zeros(4, 6);
%         dXdH(:, 1)=(X0./N)';
%         dXdH(:, 2)=(Y0./N)';
%         dXdH(:, 5)=(-N1./N.^2.*X0)';
%         dXdH(:, 6)=(-N1./N.^2.*Y0)';
%         dYdH(:, 3)=(X0./N)';
%         dYdH(:, 4)=(Y0./N)';
%         dYdH(:, 5)=(-N2./N.^2.*X0)';
%         dYdH(:, 6)=(-N2./N.^2.*Y0)';
%         dSdX=zeros(1, 4);
%         dSdY=zeros(1, 4);
%         e1=[X(2)-X(1); Y(2)-Y(1)];
%         e2=[X(2)-X(3); Y(2)-Y(3)];
%         e3=[X(4)-X(3); Y(4)-Y(3)];
%         e4=[X(4)-X(1); Y(4)-Y(1)];
%         norm_e1=norm(e1);
%         norm_e2=norm(e2);
%         norm_e3=norm(e3);
%         norm_e4=norm(e4);
%         e1e4=e1'*e4;
%         e2e3=e2'*e3;
%         P1=sqrt(norm_e1^2*norm_e4^2-e1e4^2);
%         P2=sqrt(norm_e2^2*norm_e3^2-e2e3^2);
%         dP1dX=zeros(1, 4);
%         dP1dY=zeros(1, 4);
%         dP2dX=zeros(1, 4);
%         dP2dY=zeros(1, 4);
%         dP1dX(1)=(norm_e4^2*2*(X(1)-X(2))+norm_e1^2*2*(X(1)-X(4))-2*e1e4*(2*X(1)-X(2)-X(4)))/(2*P1);
%         dP1dX(2)=(norm_e4^2*2*(X(2)-X(1))-2*e1e4*(X(4)-X(1)))/(2*P1);
%         dP1dX(4)=(norm_e1^2*2*(X(4)-X(1))-2*e1e4*(X(2)-X(1)))/(2*P1);
%         dP1dY(1)=(norm_e4^2*2*(Y(1)-Y(2))+norm_e1^2*2*(Y(1)-Y(4))-2*e1e4*(2*Y(1)-Y(2)-Y(4)))/(2*P1);
%         dP1dY(2)=(norm_e4^2*2*(Y(2)-Y(1))-2*e1e4*(Y(4)-Y(1)))/(2*P1);
%         dP1dY(4)=(norm_e1^2*2*(Y(4)-Y(1))-2*e1e4*(Y(2)-Y(1)))/(2*P1);
%         dP2dX(2)=(norm_e3^2*2*(X(2)-X(3))-2*e2e3*(X(4)-X(3)))/(2*P2);
%         dP2dX(3)=(norm_e3^2*2*(X(3)-X(2))+norm_e2^2*2*(X(3)-X(4))-2*e2e3*(2*X(3)-X(2)-X(4)))/(2*P2);
%         dP2dX(4)=(norm_e2^2*2*(X(4)-X(3))-2*e2e3*(X(2)-X(3)))/(2*P2);
%         dP2dY(2)=(norm_e3^2*2*(Y(2)-Y(3))-2*e2e3*(Y(4)-Y(3)))/(2*P2);
%         dP2dY(3)=(norm_e3^2*2*(Y(3)-Y(2))+norm_e2^2*2*(Y(3)-Y(4))-2*e2e3*(2*Y(3)-Y(2)-Y(4)))/(2*P2);
%         dP2dY(4)=(norm_e2^2*2*(Y(4)-Y(3))-2*e2e3*(Y(2)-Y(3)))/(2*P2);
%         dSdX=dP1dX+dP2dX;
%         dSdY=dP1dY+dP2dY;
%         S(1, :)=dSdX*dXdH+dSdY*dYdH;
%         
%         dCdX=zeros(1, 4);
%         dCdY=zeros(1, 4);
%         N1=norm_e1^2+norm_e3^2;
%         N=norm_e2^2+norm_e4^2;
%         dCdX(1)=2*(X(1)-X(2))/N+(-N1/N^2)*2*(X(1)-X(4));
%         dCdX(2)=2*(X(2)-X(1))/N+(-N1/N^2)*2*(X(2)-X(3));
%         dCdX(3)=2*(X(3)-X(4))/N+(-N1/N^2)*2*(X(3)-X(2));
%         dCdX(4)=2*(X(4)-X(3))/N+(-N1/N^2)*2*(X(4)-X(1));
%         dCdY(1)=2*(Y(1)-Y(2))/N+(-N1/N^2)*2*(Y(1)-Y(4));
%         dCdY(2)=2*(Y(2)-Y(1))/N+(-N1/N^2)*2*(Y(2)-Y(3));
%         dCdY(3)=2*(Y(3)-Y(4))/N+(-N1/N^2)*2*(Y(3)-Y(2));
%         dCdY(4)=2*(Y(4)-Y(3))/N+(-N1/N^2)*2*(Y(4)-Y(1));
%         S(2, :)=dCdX*dXdH+dCdY*dYdH;
%         S=zeros(2, 6);
%         vec1=[tau(1);tau(3)];
%         vec2=[tau(2);tau(4)];
%         V=sqrt(norm(vec1)^2*norm(vec2)^2-(vec1'*vec2)^2);
%         S(1, 1)=(tau(1)*norm(vec2)^2-vec1'*vec2*tau(2))/V;
%         S(1, 2)=(tau(2)*norm(vec1)^2-vec1'*vec2*tau(1))/V;
%         S(1, 3)=(tau(3)*norm(vec2)^2-vec1'*vec2*tau(4))/V;
%         S(1, 4)=(tau(4)*norm(vec1)^2-vec1'*vec2*tau(3))/V;
%         S(2, 1)=2*tau(1);
%         S(2, 2)=-2*tau(2);
%         S(2, 3)=2*tau(3);
%         S(2, 4)=-2*tau(4);
%         S=zeros(0, 6);
end