pragma Source_File_Name (Ada_Main, Spec_File_Name => "b~main.ads");
pragma Source_File_Name (Ada_Main, Body_File_Name => "b~main.adb");

package body Ada_Main is
   procedure adainit is

      procedure Set_Globals
        (Main_Priority            : Integer;
         Time_Slice_Value         : Integer;
         WC_Encoding              : Character;
         Locking_Policy           : Character;
         Queuing_Policy           : Character;
         Task_Dispatching_Policy  : Character;
         Adafinal                 : System.Address;
         Unreserve_All_Interrupts : Boolean;
         Exception_Tracebacks     : Boolean);
      pragma Import (C, Set_Globals, "__gnat_set_globals");

   begin
      Set_Globals
        (Main_Priority            => 0,
         Time_Slice_Value         => 0,
         WC_Encoding              => 'b',
         Locking_Policy           => 'C',
         Queuing_Policy           => ' ',
         Task_Dispatching_Policy  => 'F',
         Adafinal                 => adafinal'Address,
         Unreserve_All_Interrupts => False,
         Exception_Tracebacks     => False);
      -- Ada'Elab_Spec;
      -- Ada.Characters'Elab_Spec;
      -- Ada.Characters.Latin_1'Elab_Spec;
      -- Gnat'Elab_Spec;
      -- Gnat.Heap_Sort_A'Elab_Spec;
      -- Gnat.Heap_Sort_A'Elab_Body;
      -- Gnat.Htable'Elab_Spec;
      -- Gnat.Htable'Elab_Body;
      -- Interfaces'Elab_Spec;
      -- fss'elab_spec;
      -- Kernel'Elab_Spec;
      -- Kernel.Parameters'Elab_Spec;
      -- System'Elab_Spec;
      -- System.Arith_64'Elab_Spec;
      -- System.Exn_Gen'Elab_Spec;
      -- System.Exn_Gen'Elab_Body;
      -- System.Img_Int'Elab_Spec;
      -- System.Img_Real'Elab_Spec;
      -- System.Machine_Code'Elab_Spec;
      -- System.Os_Primitives'Elab_Spec;
      -- System.Os_Primitives'Elab_Body;
      -- System.Parameters'Elab_Spec;
      -- System.Parameters'Elab_Body;
         Interfaces.C_Streams'Elab_Spec;
      -- Interfaces.C_Streams'Elab_Body;
      -- System.Powten_Table'Elab_Spec;
      -- System.Standard_Library'Elab_Spec;
         Ada.Exceptions'Elab_Spec;
      -- System.Exception_Table'Elab_Spec;
         System.Exception_Table'Elab_Body;
         Ada.Io_Exceptions'Elab_Spec;
         Ada.Numerics'Elab_Spec;
      -- Ada.Numerics.Aux'Elab_Spec;
         Interfaces.C'Elab_Spec;
         System.Exceptions'Elab_Spec;
      -- System.Storage_Elements'Elab_Spec;
      -- System.Storage_Elements'Elab_Body;
      -- System.Machine_State_Operations'Elab_Spec;
      -- System.Machine_State_Operations'Elab_Body;
      -- System.Secondary_Stack'Elab_Spec;
      -- Interfaces.C'Elab_Body;
      -- System.Img_Int'Elab_Body;
         System.Stack_Checking'Elab_Spec;
      -- System.Soft_Links'Elab_Spec;
         System.Soft_Links'Elab_Body;
      -- System.Stack_Checking'Elab_Body;
         System.Secondary_Stack'Elab_Body;
      -- System.Exn_Flt'Elab_Spec;
      -- System.String_Ops'Elab_Spec;
      -- System.String_Ops'Elab_Body;
         Ada.Tags'Elab_Spec;
         Ada.Tags'Elab_Body;
         Ada.Streams'Elab_Spec;
      -- System.String_Ops_Concat_3'Elab_Spec;
      -- System.String_Ops_Concat_3'Elab_Body;
      -- System.Task_Info'Elab_Spec;
      -- System.Task_Info'Elab_Body;
      -- System.Traceback'Elab_Spec;
      -- System.Traceback'Elab_Body;
         Ada.Exceptions'Elab_Body;
      -- System.Unsigned_Types'Elab_Spec;
      -- System.Fat_Flt'Elab_Spec;
      -- Ada.Numerics.Elementary_Functions'Elab_Spec;
      -- Ada.Numerics.Elementary_Functions'Elab_Body;
      -- System.Fat_Llf'Elab_Spec;
      -- System.Img_Llu'Elab_Spec;
      -- System.Img_Llu'Elab_Body;
      -- System.Img_Uns'Elab_Spec;
      -- System.Img_Uns'Elab_Body;
      -- System.Img_Real'Elab_Body;
      -- System.Stream_Attributes'Elab_Spec;
      -- System.Stream_Attributes'Elab_Body;
         System.Finalization_Root'Elab_Spec;
      -- System.Finalization_Root'Elab_Body;
         Gnat.Exceptions'Elab_Spec;
      -- System.Arith_64'Elab_Body;
         System.Finalization_Implementation'Elab_Spec;
      -- System.Finalization_Implementation'Elab_Body;
         Ada.Finalization'Elab_Spec;
      -- Ada.Finalization'Elab_Body;
         Ada.Finalization.List_Controller'Elab_Spec;
      -- Ada.Finalization.List_Controller'Elab_Body;
         System.File_Control_Block'Elab_Spec;
      -- System.File_Io'Elab_Spec;
         System.File_Io'Elab_Body;
      -- main'elab_body;
      -- Kernel.Cpu_Primitives'Elab_Spec;
         Kernel.Cpu_Primitives'Elab_Body;
      -- Kernel.Memory'Elab_Spec;
      -- Kernel.Peripherals'Elab_Spec;
         Kernel.Peripherals.Registers'Elab_Spec;
         Kernel.Peripherals'Elab_Body;
         Kernel.Memory'Elab_Body;
      -- Kernel.Serial_Output'Elab_Spec;
         Kernel.Serial_Output'Elab_Body;
      -- Kernel.Time'Elab_Spec;
         Kernel.Threads'Elab_Spec;
      -- System.Task_Primitives'Elab_Spec;
      -- System.Tasking'Elab_Spec;
      -- System.Standard_Library'Elab_Body;
      -- System.Tasking.Restricted'Elab_Spec;
      -- Kernel.Threads.Protection'Elab_Spec;
      -- Kernel.Threads.Queues'Elab_Spec;
         Kernel.Threads.Queues'Elab_Body;
         Kernel.Threads.Protection'Elab_Body;
         Kernel.Threads'Elab_Body;
      -- Kernel.Interrupts'Elab_Spec;
         Kernel.Interrupts'Elab_Body;
         Kernel.Time'Elab_Body;
      -- System.Os_Interface'Elab_Spec;
      -- System.Os_Interface'Elab_Body;
         System.Tasking.Debug'Elab_Spec;
      -- Kernel.Threads.Atcb'Elab_Spec;
         Kernel.Threads.Atcb'Elab_Body;
      -- System.Task_Primitives.Operations'Elab_Spec;
         System.Task_Primitives.Operations'Elab_Body;
         System.Tasking.Debug'Elab_Body;
         System.Tasking'Elab_Body;
      -- Ada.Real_Time'Elab_Spec;
      -- Ada.Real_Time'Elab_Body;
      -- Ada.Real_Time.Delays'Elab_Spec;
      -- Ada.Real_Time.Delays'Elab_Body;
         Ada.Text_Io'Elab_Spec;
         Ada.Text_Io'Elab_Body;
      -- System.Tasking.Protected_Objects'Elab_Spec;
      -- System.Tasking.Protected_Objects'Elab_Body;
      -- System.Tasking.Restricted.Stages'Elab_Spec;
         System.Tasking.Restricted.Stages'Elab_Body;
         control_visualizacion_aeronave'elab_spec;
      -- Devicesfss_V1'Elab_Spec;
         datos_aeronave'elab_spec;
         datos_aeronave'elab_body;
         datos_posalt_vel'elab_spec;
         datos_posalt_vel'elab_body;
         Scenario_V1'Elab_Spec;
         tools'elab_spec;
         Devicesfss_V1'Elab_Body;
         Workload'Elab_Spec;
         Workload'Elab_Body;
         tools'elab_body;
         control_visualizacion_aeronave'elab_body;
         control_detector_obstaculos'elab_spec;
         control_detector_obstaculos'elab_body;
         control_posicion_altitud'elab_spec;
         control_posicion_altitud'elab_body;
         control_velocidad_aeronave'elab_spec;
         control_velocidad_aeronave'elab_body;
         fss'elab_body;
      null;
   end adainit;

   procedure adafinal is

      procedure do_finalize;
      pragma Import
        (C, do_finalize,
         "system__finalization_implementation__finalize_global_list");

   begin
      do_finalize;
   end adafinal;

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure initialize;
      pragma Import (C, initialize, "__gnat_initialize");

      procedure finalize;
      pragma Import (C, finalize, "__gnat_finalize");


      procedure Ada_Main_Program;
      pragma Import (Ada, Ada_Main_Program, "_ada_main");

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize;
      adainit;
      Break_Start;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

-- BEGIN Object file/option list
   --   ./main.o
   --   ./datos_aeronave.o
   --   ./datos_posalt_vel.o
   --   ./scenario_v1.o
   --   ./devicesfss_v1.o
   --   ./workload.o
   --   ./tools.o
   --   ./control_visualizacion_aeronave.o
   --   ./control_detector_obstaculos.o
   --   ./control_posicion_altitud.o
   --   ./control_velocidad_aeronave.o
   --   ./fss.o
   --   -L./
   --   -L/usr/local/openravenscar/lib/gcc-lib/sparc-ork-elf/2.8.1/adalib/
   --   /usr/local/openravenscar/lib/gcc-lib/sparc-ork-elf/2.8.1/adalib/libgnarl.a
   --   /usr/local/openravenscar/lib/gcc-lib/sparc-ork-elf/2.8.1/adalib/libgnat.a
   --   -lm
-- END Object file/option list   

end Ada_Main;
