with Ada.Text_Io; use  Ada.Text_Io;
with def_monitor; use def_monitor;
with Ada.Numerics.Discrete_Random;

procedure baboons_simulation is

  NBABOONS : constant integer := 5; -- north baboons total
  SBABOONS : constant integer := 5; -- south baboons total
  it : constant integer := 3; -- iterations
  
  monitor : BMonitor; -- baboons monitor
  
  type sleepRange is range 1 .. 3; -- delays will last between 1 to 3 seconds
  package time is new Ada.Numerics.Discrete_Random (sleepRange);
  Generador : time.Generator; -- random number generator

  task type northbaboon is
    entry Start (Idx : in integer);
  end northbaboon;

  task type southbaboon is
    entry Start (Idx : in integer);
  end southbaboon;

  -- Going up procedure: delays de task randomly
  procedure sleep is 
  begin
    delay Duration (time.Random (Generador)); -- random delay
  end sleep;

  -- North Baboon Body Task
  task body northbaboon is
    My_Idx : integer;
  begin
    accept Start (Idx : in integer) do
      My_Idx := Idx;
    end Start;
      Put_Line ("Hi! I'm baboon north" & My_Idx'img); 
      for i in 1..it loop
        monitor.northLock;
        Put_Line("North" & My_Idx'img & " is on the rope crossing to the South");
        sleep; -- crossing
        monitor.northUnlock;
        Put_Line("North" & My_Idx'img & " has arrived to the South");
        sleep; -- going back to the hill
        Put_Line("North" & My_Idx'img & ":" & i'img & " lap out of"& it'img);
      end loop;
  end northbaboon;

  -- South Baboon Body Task
  task body southbaboon is
    My_Idx : integer;
  begin
    accept Start (Idx : in integer) do
      My_Idx := Idx;
    end Start;
      Put_Line ("Hi! I'm baboon south" & My_Idx'img);  
      for i in 1..it loop
        monitor.southLock;
        Put_Line("South" & My_Idx'img & " is on the rope crossing to the North");
        sleep; -- crossing
        monitor.southUnlock;
        Put_Line("South" & My_Idx'img & " has arrived to the North");
        sleep; -- going back to the hill
        Put_Line("South" & My_Idx'img & ":" & i'img & " lap out of"& it'img);
      end loop;
  end southbaboon;

  -- Tasks array
  type arrayNbaboons is array (1..NBABOONS) of northbaboon;
  type arraySbaboons is array (1..SBABOONS) of southbaboon;
  nb : arrayNbaboons;
  sb : arraySbaboons;

begin
  -- Tasks initialization
  for Idx in 1..NBABOONS loop
    nb(Idx).Start(Idx);
    sb(Idx).Start(Idx);
  end loop;

end baboons_simulation;