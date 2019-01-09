{$n+}
program luogui_menu;

uses
  Crt, Graph,dos;

var
  Gd, Gm ,x1,y1,x2,y2,err: Integer;
  f:text;
  p:pointer;
  bitmap,xyz:word;
  sss:string;

  procedure error;
   var
    ch:char;
    begin
     setfillstyle(1,14);
     setcolor(7);
     bar(2,451,637,477);
     rectangle(3,452,636,476);
     setcolor(0);
     rectangle(1,450,638,478);
     outtextxy(5,460,sss);
      repeat
      until keypressed;
     ch:=readkey;
      if ord(ch)=0 then ch:=readkey;
     setfillstyle(1,2);
     bar(0,450,640,480);
     err:=0;
  end;

{================================ SUB_1 ====================================}

procedure sub_1;
 type
 lg=record
  x,k:integer;
 end;
 var
  c:array[1..50] of lg;
  s,ll:string;
  cha:char;
  len:integer;
  Gd, Gm ,qq: Integer;

  function sqrl(x:real;n:Integer):extended;
    var
     i:integer;
     su:real;
     begin
      su:=1;
      for i:=1 to abs(n) do
        su:=su*x;
      if (n<0) and (su<>0) then sqrl:=1/su
       else
        sqrl:=su;
     end;

   function main(n:real):real;
     var
      i,j:Integer;
      su:real;
     begin
       su:=0;
         for i:=1 to len do
          su:=su+c[i].k*sqrl(n,c[i].x);
        main:=su;
     end;


   procedure luogui(var ss:string);
     var
      i,j,t,x1,x2:Integer;
      k:string;
       begin
         for i:=1 to length(ss) do
          if ss[i] in ['A'..'Z'] then ss[i]:=chr(ord(ss[i])+32);
         while pos(')(',ss)<>0 do
          insert('*',ss,pos(')(',ss)+1);
          if pos(')^',ss)<>0 then
            begin
             j:=pos(')^',ss)+1;
             delete(ss,j,1);
             k:='';
              while (j<=length(ss)) and (ss[j] in ['0'..'9','.']) do
                begin
                 k:=k+ss[j];
                 delete(ss,j,1);
                end;
              val(k,t,i);
              k:=')';
              x1:=0;
              x2:=1;
              dec(j,2);
             while (j>0) and (x1<>x2) do
              begin
               k:=ss[j]+k;
               case ss[j] of
                '(':inc(x1);
                ')':inc(x2);
                end;
                dec(j);
               end;
              if j=0 then
                begin sss:='Error the equation accept.';
                 error;
                 exit;
                end;

              if t=0 then
                begin
                 delete(ss,j,length(k));
                 insert('1',ss,j+1);
                end
               else
                 for i:=1 to t-1 do
                  begin
                   if length(ss+k+'*')>255 then
                     begin
                      sss:='The equation is too long';
                      error;
                      exit;
                      end;
                    insert(k+'*',ss,j+1);
                   end;
               end;
         end;


   function ready(ss:string;var i:integer;j:integer):string;
    var
     p:string;
    begin
      p:='';
      case j of
       1:
         while (i<=length(ss)) and (ss[i] in ['0'..'9','.']) do
          begin p:=p+ss[i];inc(i) end;
       2:
         while (i<=length(ss)) and (ss[i] in ['a'..'z','^']) do
           if ss[i]='^' then begin inc(i);
             if ss[i]='-' then begin inc(i); p:='-'; end;
           p:=p+ready(ss,i,1) end
            else
          inc(i);
       end;
       if p='' then ready:='1' else ready:=p;
     end;


   function zhu:string;
     var
      i,j,p:integer;
      h:lg;
      s1,s2:string;
       begin
         p:=len;
            for i:=1 to p do
             for j:=i+1 to p do
              if c[i].x=c[j].x then
               begin
                c[i].k:=c[i].k+c[j].k;
                if c[i].k=0 then c[i].x:=0;
                c[j].k:=0;c[j].x:=0;
               end;
             while c[p].k=0 do dec(p);
              for i:=1 to p do
              if c[i].k=0 then
                 begin
                   j:=i+1;
                    while (j<=p) and (c[j].k=0) do inc(j);
                   c[i].k:=c[j].k;
                   c[i].x:=c[j].x;
                   c[j].k:=0;
                   c[j].x:=0;
                 end;
             while c[p].k=0 do dec(p);
              if c[1].k<0 then
                begin
                 i:=2;
                 while (i<p) and (c[i].k<0) do
                   inc(i);
                 if c[i].k>0 then
                    begin
                     h.x:=c[1].x;
                     h.k:=c[1].k;
                     c[1].x:=c[i].x;
                     c[1].k:=c[i].k;
                     c[i].x:=h.x;
                     c[i].k:=h.k;
                    end;
                 end;
                len:=p;
                s1:='';

                for i:=1 to len-1 do
                 for j:= i+1 to len do
                   if c[i].x<c[j].x then
                    begin
                     p:=c[i].x;
                     c[i].x:=c[i].k;
                     c[i].k:=c[j].k;
                     c[j].k:=c[i].x;
                     c[i].x:=c[j].x;
                     c[j].x:=p;
                    end;

               if len<>1 then
                 s1:='(';
                 str(c[1].k,s2);
                 if (abs(c[1].k)=1) and (c[1].x=0) then s1:=s1+s2;
                 if (c[1].k<0) then s1:=s1+s2;
                 if (c[1].k>1) then s1:=s1+s2;
                 str(c[1].x,s2);
                 if c[1].x=1 then s1:=s1+cha
                  else
                   if c[1].x<>0 then s1:=s1+cha+'^'+s2;
              for i:=2 to len do
               begin
                 str(c[i].k,s2);
                 if (c[i].k=1) and (c[i].x=0) then s1:=s1+'+'+s2;
                 if (c[i].k=-1) and (c[i].x=0) then s1:=s1+s2;
                 if (c[i].k<0) then s1:=s1+s2;
                 if (c[i].k>1) then s1:=s1+'+'+s2;
                 str(c[i].x,s2);
                 if c[i].x=1 then s1:=s1+cha
                  else
                   if c[i].x<>0 then s1:=s1+cha+'^'+s2;
               end;
              if len<>1 then s1:=s1+')';
              zhu:=s1;
             end;

   function lost(ss:string):string;
    var
     y,x,l:integer;
     s2:string;
      begin
       s2:=ss;
       l:=1;
       x:=0;
       y:=0;
        while length(s2)>=1 do
         begin
          if s2[1]='(' then inc(x);
          if s2[1]=')' then inc(y);
          if s2[1] in ['0'..'9','a'..'z'] then l:=2;
          delete(s2,1,1);
         end;
        if (x<>y) or (l<>2) then
          begin
           sss:='Error the equation accept.';
           err:=5;
           exit;
          end;
       l:=length(ss);
       y:=1;
        while y<=length(ss) do
         begin
          if (ss[y]=')') and ((y+1>l) or (ss[y+1]<>'*')) then
           begin
            x:=y-1;
             while ss[x]<>'(' do dec(x);
             if (x=1) or (ss[x-1]<>'*') and (ss[x-1]<>'-') then
              begin
               delete(ss,y,1);
               delete(ss,x,1);
               y:=y-2;
              end
              else
               if ss[x-1]='-' then
                begin
                 delete(ss,x,1);
                 if ss[x]='-' then begin
                   delete(ss,x-1,1);
                   ss[x-1]:='+' end;
                  while ss[x]<>')' do
                   begin
                    inc(x);
                    if ss[x]='+' then ss[x]:='-'
                   else
                    if ss[x]='-' then ss[x]:='+';
                   end;
                  delete(ss,x,1);
                 y:=y-2;
               end;
             l:=l-2;
            end;
           y:=y+1;
          end;
         lost:=ss;
       end;

    function sum(ss:string):string;
     var
      p,y,i,j,k:integer;
      s1:string;
      ch:char;
      h:lg;
      a:array[1..2,1..15] of lg;
      l:array[1..2] of integer;
     begin
      i:=1;
      fillchar(a,sizeof(a),0);
      p:=1;
      l[1]:=0;l[2]:=0;
       while i<=length(ss) do
         begin
          case ss[i] of
           '*':p:=2;
           '+','-':ch:=ss[i];
           'a'..'z':begin
                     if (i>1) and (ss[i-1] in ['0'..'9']) then
                        begin
                         val(ready(ss,i,2),a[p,l[p]].x,y);
                         dec(i);
                        end
                     else
                      begin
                       inc(l[p]);
                       if ss[i-1]='-' then a[p,l[p]].k:=-1
                        else a[p,l[p]].k:=1;
                       val(ready(ss,i,2),a[p,l[p]].x,y);
                       dec(i);
                      end;
                     end;
           '0'..'9':begin
                    if (i=1) or (ss[i-1]<>'^') then
                     begin
                      inc(l[p]);
                      if (i<>1) and (ss[i-1]='-') then
                        begin
                          val(ready(ss,i,1),a[p,l[p]].k,y);
                          dec(i);
                          a[p,l[p]].k:=-a[p,l[p]].k
                        end
                        else
                        begin
                         val(ready(ss,i,1),a[p,l[p]].k,y);
                         dec(i);
                        end;
                      end;
                 end;
              end;
            i:=i+1;
          end;
         if p<>1 then
          begin
           p:=0;
           for i:=1 to l[1] do
            for j:=1 to l[2] do
              begin
               inc(p);
               c[p].k:=a[1,i].k*a[2,j].k;
               c[p].x:=a[1,i].x+a[2,j].x;
               if c[p].x>5 then
                begin
                 err:=5;
                 sss:=' Exponent too big. (exponent<=5)';
                 sum:='';
                end;
              end;
            len:=p;
           if qq=2 then exit;
          end
       else
         begin
          for i:=1 to l[1] do
           begin
            c[i].k:=a[1,i].k;
            c[i].x:=a[1,i].x;
           end;
          len:=l[1];
         end;
          sum:=zhu;
         end;


   function gui(ss:string):string;
     var
      y,l1,l2,x:integer;
      p:string;
       begin
        y:=1;
        l1:=0;
        l2:=0;
         while y<=length(ss) do
          begin
           x:=pos('(',ss);
           if ss[y]='(' then inc(l1);
           if ss[y]=')' then inc(l2);
            if l1-l2>=2 then
              begin
               x:=y+1;
                while (l1-l2>=1) do
                 begin
                  if ss[x]='(' then inc(l1);
                  if ss[x]=')' then begin
                    inc(l2);
                    if (l1-l2=1) and
                    ((x+1>length(ss)) or (ss[x+1] in ['+','-',')']))
                     then
                      begin
                      p:=copy(ss,y,x-y+1);
                      p:=gui(p);
                      delete(ss,y,x-y+1);
                      insert(p,ss,y);
                      ss:=lost(ss);
                   y:=1;
                 l1:=0;
                l2:=0;
               end;
              end;
             inc(x);
            end;
          end
         else
          begin
           if (x<>0) and (l1=l2) and
           (ss[y]=')') and (pos('*',copy(ss,x,y-x+1))<>0) then
            begin
             p:=copy(ss,x,y-x+1);
             p:=sum(p);
             if err=5 then exit;
             delete(ss,x,y-x+1);
             insert(p,ss,x);
             y:=0;
             l1:=0;
             l2:=0;
            end;
          end;
         y:=y+1;
        end;

       while (pos('(',ss)=0) and (pos(')',ss)=0) and (pos('*',ss)<>0) do
         begin
          y:=pos('*',ss);
          x:=y+1;
           while (y>0) and (ss[y]<>'+') and (ss[y]<>'-') do dec(y);
           while (x<=length(ss)) and (ss[x]<>'+') and (ss[x]<>'-')
             and (ss[x]<>'*') do inc(x);
           p:=copy(ss,y+1,x-y-1);
           p:=sum(p);

          if err=5 then exit;
          delete(ss,y+1,x-y-1);
          insert(p,ss,y+1);
          ss:=lost(ss);
          end;
        ss:=sum(ss);
        gui:=ss;
       end;

  procedure llgg(x1,y1,p:integer);
   var
    i,j:integer;
    x2,y2:integer;
    x,y,l:extended;
    s1:longint;
    ss:string;
     begin
     
     setcolor(15);
     l:=300/p;
     line(0,y1,639,y1);
      line(610,y1-5,639,y1);
      line(610,y1+5,639,y1);
     line(x1,0,x1,479);
      line(x1-5,20,x1,0);
      line(x1+5,20,x1,0);
       for i:=-y1 to 480-y1 do
        if i mod p=0 then
         begin
          putpixel(x1+1,i+y1,15);
          putpixel(x1-1,i+y1,15);
           end;

       for j:=-x1 to 640-x1 do
        if j mod p=0 then
         begin
          putpixel(j+x1,y1-1,15);
          putpixel(j+x1,y1+1,15);
         end;

        x:=-x1/p;
         while x<=(640-x1)/p do
           begin
            y:=-main(x);
            i:=round(x*p+x1);
            j:=round(y*p+y1);
            putpixel(i,j,15);
            x:=x+0.15/p;
          end;

     setcolor(14);
     str(p*5,ss);
     outtextxy(2,10,'Rate: '+ss+'%');
     outtextxy(2,30,'Move     Picture:   <- ->');
     outtextxy(2,50,'Increase Picture: <');
     outtextxy(2,70,'Diminish Picture: >');
     outtextxy(2,90,'Reset    Picture: F1');
     outtextxy(2,110,'Equation: '+s);
      if s<>ll then
     outtextxy(2,130,'         ='+ll);
     setcolor(4);
     outtextxy(6,460,'Press Esc key reture MENU...');
    end;

  procedure lug;
    var
     x1,y1:integer;
     p:word;
     ch:char;
   begin
     cleardevice;
     p:=20;
     x1:=320;y1:=300;
      llgg(x1,y1,p);
      repeat
       ch:=readkey;
       if ord(ch)=0 then ch:=readkey;
        case ord(ch) of
         59:begin
             p:=20;
             x1:=320;
             y1:=300;
            end;
         27:exit;
         72:y1:=y1-p;
         77:x1:=x1+p;
         80:y1:=y1+p;
         75:x1:=x1-p;
         44,60:
          if p<20 then inc(p)
           else inc(p,10);
         62,46:
          if p<=20 then dec(p)
           else dec(p,10);
         end;
        if p=0 then p:=1;
      cleardevice;
      llgg(x1,y1,p);
   until 1<0;
   end;

   procedure xxx(ss:string);
    var
     i:integer;
     begin
      len:=1;
       qq:=2;
       ss:=sum(ss);
       while c[len].k<>0 do inc(len);
       dec(len);
      end;

 procedure bbs;
   begin
     setfillstyle(1,2);
     bar(0,0,640,480);
     textcolor(4);
     textbackground(2);
     setcolor(9);
     setfillstyle(1,3);
      bar(100,80,350,100);
      rectangle(99,79,351,101);
      rectangle(158,126,481,193);
     window(21,9,60,12);
      setcolor(0);
      rectangle(98,78,352,102);
      setfillstyle(1,0);
      bar(159,127,480,192);
      setcolor(8);
      outtextxy(101,86,'Please input Maths''s equation:');
      settextstyle(1,0,2);
      setcolor(4);
     outtextxy(123,120,' y=');
      setcolor(15);
      settextstyle(1,0,1);
      outtextxy(125,210,'For Example:');
      settextstyle(5,0,1); setcolor(0);
      outtextxy(170,250,'X*X*X=X^3');
      outtextxy(170,270,'3*X=3X');
      outtextxy(170,290,'(X+2)*(X+2)=(X+2)^2');
      readln(s);
     if length(s)=0 then begin sss:=' Equation is empty.';
         err:=5; end;
     if pos('/',s)<>0 then begin sss:=' Equation have "/".';
         err:=5; end;
     window(0,0,24,79);
   end;

begin
    bbs;
    if err=5 then
      begin
       error;
       exit;
      end;
    qq:=0;
    cha:='x';
     fillchar(c,sizeof(c),0);
     ll:='('+s+')';
     luogui(ll);
     ll:=lost(ll);
     if ll='' then
       begin
        sss:='Error the equation accept.';
        err:=5;
       end;
     ll:=gui(ll);
      if err=5 then
       begin
        error;
        exit;
       end;
     ll:=lost(ll);
     xxx(ll);
     lug;
   end;

{================================ END_1 ====================================}

{================================ SUB_2 ====================================}
procedure sub__2;
type
  kkk=array[1..3,1..3] of byte;
  lgmain=record
   x,y,h:byte;
   up:byte;
   k:kkk;
  end;
 const
  s:set of 0..9=[0..8];
  b:array[1..4,1..2] of shortint = ((-1,0),(0,1),(1,0),(0,-1));
  job:kkk=((1,2,3),(4,5,6),(7,8,0));

  var
   start:kkk;
   len,xx,yy,qu,out:integer;
   you:lgmain;
   win:string;
   ch:char;
   c:array[1..201] of kkk;


 procedure box(t,y,x,p:integer);
  var
   s:string;
   begin
    settextstyle(3,0,4);
      setcolor(14);
    if t=1 then
      x:=(x-1)*50+100
     else
     x:=(x-1)*50+380;
     y:=(y-1)*50+100;
     if t=1 then
      setfillstyle(1,11)
     else
      setfillstyle(1,14);
     setcolor(7);
     bar(x,y,x+50,y+50);
     rectangle(x,y,x+50,y+50);
     setcolor(0);
     rectangle(x+1,y+1,x+49,y+49);
     settextstyle(1,0,4);
     if p=0 then s:=' '
      else str(p,s);
     outtextxy(x+18,y+5,s);
   end;


 procedure bbs;
   var
    i,j:integer;
   begin
      settextstyle(1,0,2);
      setcolor(4);
      outtextxy(150,400,'Press ESC key reture MENU . . . ');
      settextstyle(1,0,4);
      setcolor(14);
      outtextxy(130,260,'yours');
      outtextxy(380,260,'computer');
      for i:=1 to 3 do
       for j:=1 to 3 do
        begin
         box(1,i,j,you.k[i,j]);
         box(2,i,j,start[i,j]);
       end;
   end;

  procedure store;
   var
    i,j,w:byte;
     begin
      randomize;
      len:=0;
      fillchar(start,sizeof(start),0);
      fillchar(c,sizeof(c),0);
       for i:=1 to 3 do
        for j:=1 to 3 do
         begin
          w:=random(9);
          while not (w in s) do
            w:=random(9);
           s:=s-[w];
           if w=0 then
            begin
             xx:=i;
             yy:=j;
            end;
            start[i,j]:=w;
         end;
     end;

procedure sub_2;
 var
  open,close,tt:integer;
  a:array[1..101] of lgmain;

  function luo(u1,u2:kkk):byte;
   var
    i,j,q:byte;
     begin
      q:=0;
      for i:=1 to 3 do
       for j:=1 to 3 do
        if u1[i,j]=u2[i,j] then inc(q);
       luo:=q;
      end;

  function bool(s:kkk):boolean;
   var
    i:integer;
     begin
      bool:=false;
      for i:=1 to open do
       if luo(s,a[i].k)=9 then
        exit;
      for i:=1 to len do
       if luo(s,c[i])=9 then
        exit;
       bool:=true;
     end;

  procedure sys;
   var
    o:kkk;
    i,j,s,x1,y1:integer;
    begin
     with a[close] do
      for i:=1 to 4 do
        begin
         x1:=b[i,1]+x;
         y1:=b[i,2]+y;
          if (x1<4) and (x1>0) and (y1>0) and (y1<4) then
           begin
            o:=k;
            o[x,y]:=k[x1,y1];
            o[x1,y1]:=0;
             if bool(o) then
               begin
                if open<=100 then
                 begin
                  inc(open);
                  a[open].k:=o;
                  a[open].up:=close;
                  a[open].x:=x1;
                  a[open].y:=y1;
                  a[open].h:=luo(job,o);
                  if a[open].h=9 then exit;
                 end
               else
                if luo(job,o)>a[open].h
                 then
               begin
                a[open].k:=o;
                a[open].up:=close;
                a[open].x:=x1;
                a[open].y:=y1;
                a[open].h:=luo(job,o);
                if a[open].h=9 then exit;
               end;
             end;
            end;
          end;
      end;

    function out(i:integer):integer;
      begin
       if a[i].up<>1 then
         out:=out(a[i].up)
       else
         out:=i;
      end;

    function next:integer;
     var
      i,j:integer;
       begin
        j:=1;
        for i:=2 to open do
          if a[i].h>a[j].h then j:=i;
           next:=out(j);
        end;

  begin
   open:=1;

   fillchar(a,sizeof(a),0);
   open:=1;
   close:=1;
   a[1].x:=xx;
   a[1].y:=yy;
   a[1].k:=start;
   a[1].up:=0;
   a[1].h:=luo(start,job);
    tt:=1;
   while (close<100) do
     begin
      sys;
      inc(close);
     end;
    tt:=next;
    start:=a[tt].k;
    xx:=a[tt].x;
    yy:=a[tt].y;
    qu:=luo(you.k,job);
     if qu<>9 then qu:=a[tt].h
      else
       win:='You win the Game!';
   end;

 procedure youmove;
  var
   ch:char;
   x,y:integer;
    begin
     x:=you.x;
     y:=you.y;
     repeat
      ch:=readkey;
       case ord(ch) of
        72:inc(x);
        80:dec(x);
        75:inc(y);
        77:dec(y);
        27:begin
            out:=3;
            exit;
           end;
       end;
         if x=0 then x:=1;
         if y=0 then y:=1;
         if x>3 then x:=3;
         if y>3 then y:=3;
        until (ord(ch) in [72,80,75,77]) and ((y<>you.y) or (x<>you.x));
        you.k[you.x,you.y]:=you.k[x,y];
        you.k[x,y]:=0;
        you.x:=x;
        you.y:=y;
       end;

 begin
    out:=0;
    store;
    win:='Computer wins the Game!';
    setfillstyle(1,2);
    bar(0,0,640,480);
    you.k:=start;
    you.x:=xx;
    you.y:=yy;
    bbs;
    repeat
      youmove;
      if out=3 then exit;
      bbs;
       if len<200 then
         inc(len)
        else
          len:=1;
        c[len]:=start;
      sub_2;
    until qu=9;
   settextstyle(1,0,4);
   setcolor(4);
   bbs;
   outtextxy(120,340,win);
   ch:=readkey;
   if ord(ch)=0 then ch:=readkey;
 end;

{================================ END_2 ====================================}

{================================ SUB_3 ====================================}
procedure sub__3;
var
  ii,i,p,d,x,y,out,del,sum: Integer;
  xx:array[1..2] of shortint;
  a:array[1..9] of string;
  b:array[1..9] of integer;
  ch:char;

  procedure inputname;
   begin
    settextstyle(0,0,1);
    setcolor(4);
    textcolor(4);
     outtextxy(20,120,'Please input your name:');
     setfillstyle(1,0);
     rectangle(157,142,281,161);
     bar(158,143,280,160);
     setcolor(15);
     rectangle(156,141,282,162);
     window(21,10,35,10);
     gotoxy(0,0);
     readln(a[9]);
    end;

  procedure print(t,k:integer; var s:string);
   var
    i,j:Integer;
    s1:string;
     begin
      while (s<>'') and (s[1]=' ') do delete(s,1,1);
      if length(s)>10 then s:=copy(s,1,10);
      setcolor(5);
      setfillstyle(1,9);
      bar(20,t*20+241,220,t*20+259);
      setcolor(0);
      rectangle(20,t*20+241,220,t*20+259);
      setcolor(15);
      line(38,t*20+242,38,t*20+258);
      rectangle(21,t*20+242,219,t*20+258);
      setcolor(0);
      settextstyle(0,0,1);
      outtextxy(27,t*20+247,chr(t+48));
      setcolor(15);
      outtextxy(50,t*20+247,s);
      str(k,s1);
      setcolor(4);
      outtextxy(150,t*20+247,s1);
     end;

  procedure input;
   var
    f:text;
    i:integer;
     begin
      fillchar(b,sizeof(b),0);
      assign(f,'.\bgi\menu_3.dat');
       reset(f);
        for i:=1 to 8 do
         a[i]:='';
         i:=1;
          while (not eof(f)) and (i<9) do
           begin
            readln(f,b[i],a[i]);
            print(i,b[i],a[i]);
            inc(i);
           end;
          close(f);
         end;

      procedure output;
       var
        f:text;
        i,j,k:Integer;
        s:string;
         begin
          assign(f,'.\bgi\menu_3.dat');
           rewrite(f);
            b[9]:=sum;
            for i:=1 to 8 do
             for j:=i+1 to 9 do
              if b[i]<b[j] then
                begin
                  k:=b[j]; b[j]:=b[i]; b[i]:=k;
                  s:=a[j]; a[j]:=a[i]; a[i]:=s;
                end;
               i:=1;
              while (i<9) and (b[i]<>0) do
                begin
                 writeln(f,b[i],'   ',a[i]);
                 inc(i);
                end;
              close(f);
             end;

  procedure move(t:integer);
   begin
    if t=2 then
     begin
      if d=xx[2] then setcolor(7) else
      setcolor(9);
       line(xx[2]*20+360,446,xx[2]*20+420,446);
       line(xx[2]*20+360,448,xx[2]*20+420,448);
      if d=xx[2] then setcolor(7) else
      setcolor(0);
       line(xx[2]*20+360,447,xx[2]*20+420,447);
     end
    else
     begin
      if d=xx[1] then setcolor(7) else
      setcolor(0);
       line(xx[1]*20+360,32,xx[1]*20+420,32);
       line(xx[1]*20+360,34,xx[1]*20+420,34);
      if d=xx[1] then setcolor(7) else
      setcolor(9);
       line(xx[1]*20+360,33,xx[1]*20+420,33);
      end;
   end;

function rand:integer;
 begin
  if (y=440) or (y=40) then
    rand:=2-random(5)
   else
    if x<=366 then
     rand:=random(2)
    else
     rand:=-random(2);
  end;

function bool:boolean;
 var
  s:string;
 begin
  if (y>440) or (y<40) then
     bool:=false;
  if ((y=440) and (x>=xx[2]*20+360) and (x<=xx[2]*20+420))
   or ((y=40) and (x>=xx[1]*20+360) and (x<=xx[1]*20+420)) then
    begin bool:=true;
          str(sum,s);
          inc(sum,20);
          setfillstyle(1,2);
          bar(10,10,250,50);
          setcolor(4);
          str(sum,s);
          del:=700-sum div 10;
          outtextxy(10,10,'Total: '+s);
          end
  else
    bool:=false;
  end;

procedure mover(var w,h:Integer);
  begin
   setcolor(7);
    circle(x,y,5);
    setcolor(0);
    line(360,240,580,240);
    inc(x,w);
    inc(y,h);
     circle(x,y,5);
     delay(del);
     if (y=440) and bool then
       begin
        p:=1;
        h:=-1;
        w:=rand;
        end;
     if (y=40) and bool then
       begin
        h:=1;
        p:=2;
        w:=rand;
       end;
     if (x<=366) or (x>=575)  then w:=rand;
     if (y>460) or (y<20) then out:=3;
     if out=3 then exit;
    end;



procedure da;
 var
  ch:char;
  w,h,k:integer;
 begin
  out:=0;
  xx[1]:=4;  xx[2]:=4;
  p:=2;      w:=1;
  h:=1;      d:=3;
  move(1);
  move(2);
   x:=460;
   y:=240;
   setcolor(0);
   circle(x,y,5);
   repeat
      ch:=readkey;
      d:=xx[p];
      case ord(ch) of
        75:dec(xx[p]);
        77:inc(xx[p]);
        27:begin out:=4; exit; end;
      end;
      if xx[p]<0 then xx[p]:=0;
      if xx[p]>8 then xx[p]:=8;
      if xx[p]<>d then
       begin
        k:=xx[p];
        xx[p]:=d;
        move(p);
        xx[p]:=k;
        move(p);
       end;
         repeat
          mover(w,h);
         if out=3 then exit;
         until keypressed;
    until 1<0;
  end;

  procedure bbs;
   var
   i:integer;
   begin
   Randomize;
   setfillstyle(1,2);
   bar(0,0,640,480);
   setfillstyle(1,7);
   bar(360,30,580,450);
   setcolor(0);
   rectangle(359,29,581,451);
   line(360,240,580,240);
   for i:=1 to 5 do
    begin
     line(582+i,28-i,582+i,452+i);
     line(358-i,452+i,582+i,452+i);
    end;
    setcolor(14);
    for i:=1 to 5 do
     begin
      line(358-i,28-i,358-i,452+i);
      line(358-i,28-i,582+i,28-i);
     end;
   setcolor(15);
   rectangle(358,28,582,452);
   setcolor(0);
   settextstyle(1,0,2);
   out:=0;
   input;
  end;

procedure bbs_2;
 begin
  settextstyle(5,0,1);
  setcolor(4);
  outtextxy(20,170,'Please press ''<- ->'' keys to play.');
  setcolor(15);
  outtextxy(20,430,'Press ESC reture to menu . . .');
 end;


begin
  sum:=0;
  del:=700;
  bbs;
  inputname;
  for ii:=1 to 3 do
   begin
    bbs;
    bbs_2;
    da;
    if out=4 then
     begin
      output;
      exit;
     end;
   end;
  output;
  ch:=readkey;
   if ord(ch)=0 then ch:=readkey;
end;

{================================ END_3 ====================================}

{================================ SUB_4 ====================================}

procedure sub__4;
  var
  y,x,k,no: Integer;
  a:array[1..35,1..250] of char;
  f:text;

procedure input;
 var
  i,j:integer;
  begin
   assign(f,'.\bgi\menu_4.dat');
   reset(f);
   for i:=1 to 35 do
    begin
     j:=1;
    while not eoln(f) do
    begin
     read(f,a[i,j]);
     inc(j);
    end;
   readln(f);
  end;
close(f);
end;

procedure output(x,y,c:Integer);
 var
  ch:char;
  i,j:integer;
   begin
    assign(f,'.\bgi\menu_5.dat');
    reset(f);
      for i:=1 to 16 do
      begin
       for j:=1 to 256 do
        begin
         read(f,ch);
         if ch='1' then putpixel(j+x,i+y,c);
        end;
       readln(f);
      end;
    close(f);
   end;

procedure xx1;
 var
  t:longint;
 begin

 for t:=1 to 15000 do
  begin
   y:=random(35)+1;
   x:=random(250)+1;
    if a[y,x]='1'
     then
      putpixel(x+175,y+240,random(15)+1);
     delay(50);
   end;
 end;

procedure xx3;
 var
  i,j,k:integer;
 begin
  for j:=1 to 250 do
     for k:=20 downto 0 do
     begin
       for i:=1 to 35 do
        if a[i,j]='1'
        then
         putpixel(j+175+k-1,i+240,15)
        else
         putpixel(j+175+k,i+240,no);
         delay(200);
        end;
        for k:=20 downto 0 do
          for i:=1 to 35 do
       putpixel(j+175+k-1,i+240,0);
     end;

procedure xx2;
 var
  t:integer;
begin
 for t:=1 to 15000 do
  begin
   y:=random(35)+1;
   x:=random(250)+1;
    if a[y,x]='1'
     then
      putpixel(x+175,y+240,no);
     delay(50);
   end;

  bar(150,220,460,300);
 end;


procedure bbs;
 var
  i,j:Integer;
begin
 setcolor(4);
 output(330,450,15);
 setfillstyle(1,no);
  bar(150,220,460,300);
  setcolor(15);
  rectangle(148,218,462,302);
  setcolor(4);
  rectangle(149,219,461,301);
  setcolor(8);
   for i:=2 to 10 do
    begin
     if i=10 then setcolor(5);
     line(461+i,219+i,461+i,301+i);
     line(149+i,301+i,461+i,301+i);
    end;
  end;
begin
  Randomize;
  no:=0;
  input;
  bbs;
   xx1;
   xx2;
   output(175,280,9);
   xx3;
  CloseGraph;
   CloseGraph;
   halt;
  end;

{================================ END_4 ====================================}

 procedure down;
  var
   i,j:integer;
  begin
   for i:=470-y2+y1 downto y1 do
    PutImage(x1-1,i, P^, NormalPut);
    setfillstyle(1,2);
    bar(x1-1,0,x2+3,y2+4);
    PutImage(x1-1,y1-1, P^, NormalPut);
   end;

  procedure put(x2,y2:integer);
   var
    a:string[17];
    i,j,x,y,c:integer;
     begin
     if y2=y1 then c:=13 else  c:=14;
      x:=x2+5;
      y:=y2+8;

      for i:=1 to 16 do
       begin
        readln(f,a);
         for j:=1 to 16 do
          if a[j]='1' then
           putpixel(x+i,y+j,c);
        end;

      x:=x+22;
      for i:=1 to 16 do
       begin
        readln(f,a);
         for j:=1 to 16 do
          if a[j]='1' then
           putpixel(x+i,y+j,c);
        end;
    end;

 procedure move(var l:integer);
  begin
    setcolor(2);
    outtextxy(l,30,'---Infinite luster---');
    setcolor(15);
    dec(l);
    if l=-1 then l:=640;
    outtextxy(l,30,'---Infinite luster---');
    setcolor(random(16));
    circle(500,350,random(60));
   end;

 procedure up;
  var
   i,j:integer;
  begin
   for i:=y1 downto 1 do
    PutImage(x1-1,i, P^, NormalPut);
    setfillstyle(1,2);
    bar(x1-1,0,x2+3,y2+4);
   end;

 procedure ttt(x:integer);
  var
   i,j:integer;
    begin
     x:=x+y1;
     setcolor(7);
     setwritemode(1);
      for i:=2 to 28 do
       line(x1+1,x+i,x2-1,x+i);
       setwritemode(0);
      end;

 procedure output;
  begin
   setcolor(4);
   settextstyle(5,0,1);
   outtextxy(360,60,'I  am  a  student of vocational');
   outtextxy(340,80,'technical   school   of  Miluo.');
   outtextxy(320,100,'Computer  is  my   specialty.');
   outtextxy(300,120,'I  am  interested in computer.');
   outtextxy(280,140,'program programming is my best');
   outtextxy(260,160,'hobby. My  ideal is  become an');
   outtextxy(240,180,'excellent software-maker.');
   outtextxy(220,200,'I  believe  that:  Where there');
   outtextxy(200,220,'is  a  will  there is  a  way.');
   outtextxy(180,240,'This  is  my works.Its name is');
   outtextxy(160,260,'"Maths game". It  programed in');
   outtextxy(140,280,'Turbo  Pascal. I  think  this');
   outtextxy(120,300,'program  is  very  good.  Both');
   outtextxy(100,320,'my classmates and  I  like  it');
   outtextxy( 80,340,'very much.  Do  you  think so?');
   outtextxy( 60,360,'If you have some  advice to my');
   outtextxy( 40,380,'program,please write  a letter');
   outtextxy( 20,400,'to me. My E-Mail address: ');
   setcolor(15);
   outtextxy(220,400,'Luolovegui@163.com');
   setcolor(14);
   settextstyle(3,0,2);
   outtextxy(200,420,'------Infinite luster');
  end;

 procedure sub_2_err;
  var
   ch:char;
  begin
   setfillstyle(1,2);
    bar(0,0,640,480);
    setfillstyle(1,7);
    bar(100,200,540,250);
    setcolor(0);
    rectangle(100,200,540,250);
    setcolor(4);
    rectangle(99,199,541,251);
    setcolor(4);
    rectangle(101,201,539,249);
     outtextxy(110,210,'The Game is runned the second time...');
     outtextxy(150,230,'If run the computer will be error...');
     settextstyle(1,0,3);
    ch:=readkey;
     if ord(ch)=0 then ch:=readkey;
  end;

 procedure sys;
  var
   pp,c,t:integer;
   ch:char;

    begin
     t:=640;
     pp:=1;
     ttt(pp*30);
      ch:='0';
      settextstyle(5,0,1);
      repeat
       repeat
        settextstyle(5,0,1);
        move(t);
       until keypressed;
      ch:=readkey;
      if ord(ch)=0 then ch:=readkey;
       c:=pp;
       case ord(ch) of
        72,75:dec(pp);
        77,80:inc(pp);
        27:begin sub__4; exit; end;
        13:
        begin
          bitmap := ImageSize(x1-1,y1-1,x2+3,y2+4);
          GetMem(P, bitmap);
          GetImage(x1-1,y1-1,x2+3,y2+4,P^);
          up;
           if pp=1 then sub_1;
           if pp=2 then
             begin
              if xyz=3 then
               sub_2_err
              else
               sub__2;
               xyz:=3;
             end;
           if pp=3 then sub__3;
           if pp=4 then sub__4;
           setcolor(2);
           setfillstyle(1,2);
           bar(0,0,640,480);
           down;
          output;
         end;
       end;
        if pp=5 then pp:=1;
        if pp=0 then pp:=4;
        ttt(c*30);
        ttt(pp*30);
       until 1<0;
      end;

 
begin
  Gd := Detect; InitGraph(Gd, Gm, '.\bgi');
  if GraphResult <> grOk then Halt(1);
  Randomize;
   cleardevice;
    setfillstyle(1,2);
    bar(0,0,640,480);
    x1:=45;
     y1:=50;
     x2:=95;
     y2:=199;
    rectangle(x1-1,y1-1,x2+1,y2+1);
    setfillstyle(1,9);
    bar(x1,y1,x2,y2);
     line(x1,y1+60,x2,y1+60);
     line(x1,y1+30,x2,y1+30);
     line(x1,y1+90,x2,y1+90);
     line(x1,y1+120,x2,y1+120);
     setcolor(0);
      line(x2+2,y1,x2+2,y2+2);
      line(x2+3,y1+1,x2+3,y2+3);
      line(x1,y2+2,x2+2,y2+2);
      line(x1+1,y2+3,x2+3,y2+3);
       err:=0;
       assign(f,'.\bgi\menu.dat');
       reset(f);
        put(x1,y1);
        put(x1,y1+30);
        put(x1,y1+60);
        put(x1,y1+90);
        put(x1,y1+120);
        close(f);
      xyz:=0;
      output;
      sys;
  CloseGraph;
end.
