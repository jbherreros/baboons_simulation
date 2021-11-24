with Ada.Text_Io; use  Ada.Text_Io;
package def_monitor is

    protected type BMonitor is
      entry northLock;
      procedure northUnlock;
      entry southLock; 
      procedure southUnlock;
    private
      northBaboons : integer := 0;
      southBaboons : integer := 0;
    end BMonitor;

end def_monitor;