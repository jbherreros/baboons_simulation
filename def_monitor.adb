package body def_monitor is

   protected body BMonitor is
    entry northLock when (southBaboons = 0) and (northBaboons < 3) is -- entra si nord < 3 i no sud
    begin
      northBaboons := northBaboons + 1;
      Put_Line("******" & northBaboons'img & " north baboons going to South ******"); 
    end northLock;

    procedure northUnlock is
    begin
      northBaboons := northBaboons - 1;
      Put_Line("******" & northBaboons'img & " north baboons going to South ******"); 
    end northUnlock;

    entry southLock when (northBaboons = 0) and (southBaboons < 3) is
    begin
      southBaboons := southBaboons + 1;
      Put_Line("++++++" & southBaboons'img & " south baboons going to North ++++++");
    end southLock;

    procedure southUnlock is
    begin
      southBaboons := southBaboons - 1;
      Put_Line("++++++" & southBaboons'img & " south baboons going to North ++++++"); 
    end southUnlock;

  end BMonitor;

end def_monitor;