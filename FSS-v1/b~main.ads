with System;
package Ada_Main is

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   procedure adafinal;
   pragma Export (C, adafinal);

   procedure adainit;
   pragma Export (C, adainit);

   procedure Break_Start;
   pragma Import (C, Break_Start, "__gnat_break_start");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   u00001 : constant Integer := 16#489506F5#;
   u00002 : constant Integer := 16#1D4BE45E#;
   u00003 : constant Integer := 16#31577D5D#;
   u00004 : constant Integer := 16#1E2D431A#;
   u00005 : constant Integer := 16#40408672#;
   u00006 : constant Integer := 16#2359F9ED#;
   u00007 : constant Integer := 16#56F593E8#;
   u00008 : constant Integer := 16#48126ACB#;
   u00009 : constant Integer := 16#0357E00A#;
   u00010 : constant Integer := 16#27FE3586#;
   u00011 : constant Integer := 16#56BBE4F1#;
   u00012 : constant Integer := 16#5BA06B89#;
   u00013 : constant Integer := 16#7B4AAE35#;
   u00014 : constant Integer := 16#6C6C953E#;
   u00015 : constant Integer := 16#156A40CF#;
   u00016 : constant Integer := 16#76C269C3#;
   u00017 : constant Integer := 16#7C25DE96#;
   u00018 : constant Integer := 16#65CAA177#;
   u00019 : constant Integer := 16#5F4E7864#;
   u00020 : constant Integer := 16#21031349#;
   u00021 : constant Integer := 16#6248B41E#;
   u00022 : constant Integer := 16#033DABE0#;
   u00023 : constant Integer := 16#6AB38FEA#;
   u00024 : constant Integer := 16#0221E7C8#;
   u00025 : constant Integer := 16#134B7763#;
   u00026 : constant Integer := 16#08258E1B#;
   u00027 : constant Integer := 16#367D5222#;
   u00028 : constant Integer := 16#0C63B0E1#;
   u00029 : constant Integer := 16#01D2C69F#;
   u00030 : constant Integer := 16#31FB20F4#;
   u00031 : constant Integer := 16#2F1EB794#;
   u00032 : constant Integer := 16#39F8FFC7#;
   u00033 : constant Integer := 16#6B26CE53#;
   u00034 : constant Integer := 16#595A5A0A#;
   u00035 : constant Integer := 16#3DF26A18#;
   u00036 : constant Integer := 16#0F1BB294#;
   u00037 : constant Integer := 16#2E6D0426#;
   u00038 : constant Integer := 16#40442E6A#;
   u00039 : constant Integer := 16#0651CC0C#;
   u00040 : constant Integer := 16#7B4D80ED#;
   u00041 : constant Integer := 16#742B318F#;
   u00042 : constant Integer := 16#71096D18#;
   u00043 : constant Integer := 16#03F36D98#;
   u00044 : constant Integer := 16#175F872B#;
   u00045 : constant Integer := 16#26610831#;
   u00046 : constant Integer := 16#3C88F424#;
   u00047 : constant Integer := 16#1D4F93E8#;
   u00048 : constant Integer := 16#30B2EC3D#;
   u00049 : constant Integer := 16#34054F96#;
   u00050 : constant Integer := 16#524A03E3#;
   u00051 : constant Integer := 16#3B9DA6D5#;
   u00052 : constant Integer := 16#60C36E5C#;
   u00053 : constant Integer := 16#7202CBD1#;
   u00054 : constant Integer := 16#0F7193E3#;
   u00055 : constant Integer := 16#16952D8B#;
   u00056 : constant Integer := 16#7B91C7A0#;
   u00057 : constant Integer := 16#79D09598#;
   u00058 : constant Integer := 16#6A42315C#;
   u00059 : constant Integer := 16#325DDA1F#;
   u00060 : constant Integer := 16#644FBE04#;
   u00061 : constant Integer := 16#4F9B5906#;
   u00062 : constant Integer := 16#260306DA#;
   u00063 : constant Integer := 16#54AB61A8#;
   u00064 : constant Integer := 16#6371166A#;
   u00065 : constant Integer := 16#3DEC36D4#;
   u00066 : constant Integer := 16#7EF5B3F5#;
   u00067 : constant Integer := 16#21F7877D#;
   u00068 : constant Integer := 16#0D83A3EA#;
   u00069 : constant Integer := 16#0388ABD4#;
   u00070 : constant Integer := 16#0B97C6BF#;
   u00071 : constant Integer := 16#34B32999#;
   u00072 : constant Integer := 16#4F0184F2#;
   u00073 : constant Integer := 16#0A0669D8#;
   u00074 : constant Integer := 16#66F773CD#;
   u00075 : constant Integer := 16#20A8E82B#;
   u00076 : constant Integer := 16#1CBC39CD#;
   u00077 : constant Integer := 16#63B302E3#;
   u00078 : constant Integer := 16#2DF1D194#;
   u00079 : constant Integer := 16#61E757F8#;
   u00080 : constant Integer := 16#53842B76#;
   u00081 : constant Integer := 16#4271AE2E#;
   u00082 : constant Integer := 16#736E0B75#;
   u00083 : constant Integer := 16#080C3AA1#;
   u00084 : constant Integer := 16#1120FB80#;
   u00085 : constant Integer := 16#77F167EF#;
   u00086 : constant Integer := 16#1307539C#;
   u00087 : constant Integer := 16#61897F59#;
   u00088 : constant Integer := 16#403EA0CF#;
   u00089 : constant Integer := 16#259E043B#;
   u00090 : constant Integer := 16#7BB26C80#;
   u00091 : constant Integer := 16#2E257CBC#;
   u00092 : constant Integer := 16#02301BD8#;
   u00093 : constant Integer := 16#165E2B21#;
   u00094 : constant Integer := 16#3281D913#;
   u00095 : constant Integer := 16#2D5B0A3F#;
   u00096 : constant Integer := 16#7FE58C31#;
   u00097 : constant Integer := 16#2286F49F#;
   u00098 : constant Integer := 16#48C83B8A#;
   u00099 : constant Integer := 16#60BB985C#;
   u00100 : constant Integer := 16#389187F7#;
   u00101 : constant Integer := 16#0E330148#;
   u00102 : constant Integer := 16#06C7CB2F#;
   u00103 : constant Integer := 16#17397363#;
   u00104 : constant Integer := 16#0939762D#;
   u00105 : constant Integer := 16#718BBDC5#;
   u00106 : constant Integer := 16#47929C32#;
   u00107 : constant Integer := 16#20751AB1#;
   u00108 : constant Integer := 16#38A9ACAD#;
   u00109 : constant Integer := 16#0E685CA4#;
   u00110 : constant Integer := 16#4016DC05#;
   u00111 : constant Integer := 16#1B981D87#;
   u00112 : constant Integer := 16#16585895#;
   u00113 : constant Integer := 16#4893B15C#;
   u00114 : constant Integer := 16#79CE2327#;
   u00115 : constant Integer := 16#0B5071CF#;
   u00116 : constant Integer := 16#32AE65C8#;
   u00117 : constant Integer := 16#501968FA#;
   u00118 : constant Integer := 16#454E0FB3#;
   u00119 : constant Integer := 16#7400AB3D#;
   u00120 : constant Integer := 16#5232DFDC#;
   u00121 : constant Integer := 16#428A28C5#;
   u00122 : constant Integer := 16#6A6F4396#;
   u00123 : constant Integer := 16#09BADB05#;
   u00124 : constant Integer := 16#56FB671A#;
   u00125 : constant Integer := 16#14420790#;
   u00126 : constant Integer := 16#3A26CB26#;
   u00127 : constant Integer := 16#1D1095E4#;
   u00128 : constant Integer := 16#68B56BA3#;
   u00129 : constant Integer := 16#3A53254C#;
   u00130 : constant Integer := 16#0443320F#;
   u00131 : constant Integer := 16#508A7580#;
   u00132 : constant Integer := 16#567FF625#;
   u00133 : constant Integer := 16#26EC8421#;
   u00134 : constant Integer := 16#797D8981#;
   u00135 : constant Integer := 16#72152961#;
   u00136 : constant Integer := 16#10450B1E#;
   u00137 : constant Integer := 16#0F714CF8#;
   u00138 : constant Integer := 16#4134E3F3#;
   u00139 : constant Integer := 16#79C1699E#;
   u00140 : constant Integer := 16#58CFCCB1#;
   u00141 : constant Integer := 16#55260082#;
   u00142 : constant Integer := 16#6BA0AF88#;
   u00143 : constant Integer := 16#5AD145BC#;
   u00144 : constant Integer := 16#79C702C4#;
   u00145 : constant Integer := 16#64C595A8#;
   u00146 : constant Integer := 16#5E9C6153#;
   u00147 : constant Integer := 16#57433A96#;
   u00148 : constant Integer := 16#711663DE#;

   pragma Export (C, u00001, "mainB");
   pragma Export (C, u00002, "system__standard_libraryB");
   pragma Export (C, u00003, "system__standard_libraryS");
   pragma Export (C, u00004, "fssB");
   pragma Export (C, u00005, "fssS");
   pragma Export (C, u00006, "adaS");
   pragma Export (C, u00007, "ada__real_timeB");
   pragma Export (C, u00008, "ada__real_timeS");
   pragma Export (C, u00009, "interfacesS");
   pragma Export (C, u00010, "systemS");
   pragma Export (C, u00011, "kernelS");
   pragma Export (C, u00012, "kernel__parametersS");
   pragma Export (C, u00013, "system__arith_64B");
   pragma Export (C, u00014, "system__arith_64S");
   pragma Export (C, u00015, "gnatS");
   pragma Export (C, u00016, "gnat__exceptionsS");
   pragma Export (C, u00017, "ada__streamsS");
   pragma Export (C, u00018, "ada__tagsB");
   pragma Export (C, u00019, "ada__tagsS");
   pragma Export (C, u00020, "ada__exceptionsB");
   pragma Export (C, u00021, "ada__exceptionsS");
   pragma Export (C, u00022, "gnat__heap_sort_aB");
   pragma Export (C, u00023, "gnat__heap_sort_aS");
   pragma Export (C, u00024, "system__exception_tableB");
   pragma Export (C, u00025, "system__exception_tableS");
   pragma Export (C, u00026, "gnat__htableB");
   pragma Export (C, u00027, "gnat__htableS");
   pragma Export (C, u00028, "system__exceptionsS");
   pragma Export (C, u00029, "system__machine_state_operationsB");
   pragma Export (C, u00030, "system__machine_state_operationsS");
   pragma Export (C, u00031, "system__storage_elementsB");
   pragma Export (C, u00032, "system__storage_elementsS");
   pragma Export (C, u00033, "system__secondary_stackB");
   pragma Export (C, u00034, "system__secondary_stackS");
   pragma Export (C, u00035, "system__parametersB");
   pragma Export (C, u00036, "system__parametersS");
   pragma Export (C, u00037, "system__soft_linksB");
   pragma Export (C, u00038, "system__soft_linksS");
   pragma Export (C, u00039, "system__stack_checkingB");
   pragma Export (C, u00040, "system__stack_checkingS");
   pragma Export (C, u00041, "system__tracebackB");
   pragma Export (C, u00042, "system__tracebackS");
   pragma Export (C, u00043, "system__string_opsB");
   pragma Export (C, u00044, "system__string_opsS");
   pragma Export (C, u00045, "system__finalization_rootB");
   pragma Export (C, u00046, "system__finalization_rootS");
   pragma Export (C, u00047, "system__stream_attributesB");
   pragma Export (C, u00048, "system__stream_attributesS");
   pragma Export (C, u00049, "ada__io_exceptionsS");
   pragma Export (C, u00050, "system__unsigned_typesS");
   pragma Export (C, u00051, "system__task_primitivesS");
   pragma Export (C, u00052, "kernel__threadsB");
   pragma Export (C, u00053, "kernel__threadsS");
   pragma Export (C, u00054, "kernel__memoryB");
   pragma Export (C, u00055, "kernel__memoryS");
   pragma Export (C, u00056, "kernel__peripheralsB");
   pragma Export (C, u00057, "kernel__peripheralsS");
   pragma Export (C, u00058, "kernel__peripherals__registersS");
   pragma Export (C, u00059, "kernel__threads__protectionB");
   pragma Export (C, u00060, "kernel__threads__protectionS");
   pragma Export (C, u00061, "kernel__cpu_primitivesB");
   pragma Export (C, u00062, "kernel__cpu_primitivesS");
   pragma Export (C, u00063, "system__machine_codeS");
   pragma Export (C, u00064, "kernel__threads__queuesB");
   pragma Export (C, u00065, "kernel__threads__queuesS");
   pragma Export (C, u00066, "kernel__timeB");
   pragma Export (C, u00067, "kernel__timeS");
   pragma Export (C, u00068, "kernel__interruptsB");
   pragma Export (C, u00069, "kernel__interruptsS");
   pragma Export (C, u00070, "ada__finalization__list_controllerB");
   pragma Export (C, u00071, "ada__finalization__list_controllerS");
   pragma Export (C, u00072, "ada__finalizationB");
   pragma Export (C, u00073, "ada__finalizationS");
   pragma Export (C, u00074, "system__finalization_implementationB");
   pragma Export (C, u00075, "system__finalization_implementationS");
   pragma Export (C, u00076, "system__string_ops_concat_3B");
   pragma Export (C, u00077, "system__string_ops_concat_3S");
   pragma Export (C, u00078, "system__task_primitives__operationsB");
   pragma Export (C, u00079, "system__task_primitives__operationsS");
   pragma Export (C, u00080, "kernel__threads__atcbB");
   pragma Export (C, u00081, "kernel__threads__atcbS");
   pragma Export (C, u00082, "system__os_interfaceB");
   pragma Export (C, u00083, "system__os_interfaceS");
   pragma Export (C, u00084, "system__os_primitivesB");
   pragma Export (C, u00085, "system__os_primitivesS");
   pragma Export (C, u00086, "system__taskingB");
   pragma Export (C, u00087, "system__taskingS");
   pragma Export (C, u00088, "system__task_infoB");
   pragma Export (C, u00089, "system__task_infoS");
   pragma Export (C, u00090, "system__tasking__debugB");
   pragma Export (C, u00091, "system__tasking__debugS");
   pragma Export (C, u00092, "interfaces__cB");
   pragma Export (C, u00093, "interfaces__cS");
   pragma Export (C, u00094, "control_detector_obstaculosB");
   pragma Export (C, u00095, "control_detector_obstaculosS");
   pragma Export (C, u00096, "ada__real_time__delaysB");
   pragma Export (C, u00097, "ada__real_time__delaysS");
   pragma Export (C, u00098, "ada__text_ioB");
   pragma Export (C, u00099, "ada__text_ioS");
   pragma Export (C, u00100, "interfaces__c_streamsB");
   pragma Export (C, u00101, "interfaces__c_streamsS");
   pragma Export (C, u00102, "system__file_ioB");
   pragma Export (C, u00103, "system__file_ioS");
   pragma Export (C, u00104, "system__file_control_blockS");
   pragma Export (C, u00105, "datos_aeronaveB");
   pragma Export (C, u00106, "datos_aeronaveS");
   pragma Export (C, u00107, "devicesfss_v1B");
   pragma Export (C, u00108, "devicesfss_v1S");
   pragma Export (C, u00109, "kernel__serial_outputB");
   pragma Export (C, u00110, "kernel__serial_outputS");
   pragma Export (C, u00111, "ada__charactersS");
   pragma Export (C, u00112, "ada__characters__latin_1S");
   pragma Export (C, u00113, "scenario_v1S");
   pragma Export (C, u00114, "system__img_intB");
   pragma Export (C, u00115, "system__img_intS");
   pragma Export (C, u00116, "system__img_realB");
   pragma Export (C, u00117, "system__img_realS");
   pragma Export (C, u00118, "system__fat_llfS");
   pragma Export (C, u00119, "system__img_lluB");
   pragma Export (C, u00120, "system__img_lluS");
   pragma Export (C, u00121, "system__img_unsB");
   pragma Export (C, u00122, "system__img_unsS");
   pragma Export (C, u00123, "system__powten_tableS");
   pragma Export (C, u00124, "system__tasking__protected_objectsB");
   pragma Export (C, u00125, "system__tasking__protected_objectsS");
   pragma Export (C, u00126, "toolsB");
   pragma Export (C, u00127, "toolsS");
   pragma Export (C, u00128, "workloadB");
   pragma Export (C, u00129, "workloadS");
   pragma Export (C, u00130, "ada__numericsS");
   pragma Export (C, u00131, "ada__numerics__elementary_functionsB");
   pragma Export (C, u00132, "ada__numerics__elementary_functionsS");
   pragma Export (C, u00133, "ada__numerics__auxS");
   pragma Export (C, u00134, "system__exn_fltS");
   pragma Export (C, u00135, "system__exn_genB");
   pragma Export (C, u00136, "system__exn_genS");
   pragma Export (C, u00137, "system__fat_fltS");
   pragma Export (C, u00138, "datos_posalt_velB");
   pragma Export (C, u00139, "datos_posalt_velS");
   pragma Export (C, u00140, "system__tasking__restricted__stagesB");
   pragma Export (C, u00141, "system__tasking__restricted__stagesS");
   pragma Export (C, u00142, "system__tasking__restrictedS");
   pragma Export (C, u00143, "control_posicion_altitudB");
   pragma Export (C, u00144, "control_posicion_altitudS");
   pragma Export (C, u00145, "control_velocidad_aeronaveB");
   pragma Export (C, u00146, "control_velocidad_aeronaveS");
   pragma Export (C, u00147, "control_visualizacion_aeronaveB");
   pragma Export (C, u00148, "control_visualizacion_aeronaveS");

end Ada_Main;
