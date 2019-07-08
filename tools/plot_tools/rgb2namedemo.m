function rgb2namedemo
%RGB2NAMEDEMO demo for RGB2NAME function. Choose a color then roll over the text at the bottom
% of the figure to see the color's name. Requires java.
%
% By Matt Daskilewicz <mattdaskil@gatech.edu>
% 12/2008


f=figure('units','pixels','position',[200 200 430 386],'menubar','none','toolbar','none','windowstyle','normal','numbertitle','off',...
    'name','Pick a color, then roll over text at bottom of figure','resize','off');
[j h]=javacomponent('javax.swing.JColorChooser',[0 36 430 350]);

t=uicontrol('style','text','position',[10 10 430 20],'string','Pick a color');

%j.MouseClickedCallback={@updatetext,t};

set(f,'windowbuttonupfcn',{@updatetext,t,j})
set(f,'windowbuttonmotionfcn',{@updatetext,t,j})

set(h,'buttondownfcn',{@updatetext,t,j})

%handles.j.setColor(R,G,B);

bgcolor=j.getBackground;
R=bgcolor.getRed;
G=bgcolor.getGreen;
B=bgcolor.getBlue;

set(f,'color',[R G B]/255);


function updatetext(src,ev,t,j)



newcolor=j.getColor;

R=newcolor.getRed;
G=newcolor.getGreen;
B=newcolor.getBlue;

newcolor=[R G B]/255;

name=rgb2name(newcolor);

set(t,'string',['I''d call that ',name]);



