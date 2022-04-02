________________________________________________________________________
	  Example DVI_RXTX Design Read Me
-------------------------------------------------------------------------
Object device:GW2A-18-PG484
---------------------------------------------------------------------------
File List:
---------------------------------------------------------------------------
.
|-- doc
|   `-- Readme.txt                              -->  Read Me file (this file)
|-- tb 
|   `-- tb.v                                    -->  TestBench for example design
|   `-- prim_sim.v                              -->  Gowin Simulation lib
|   |-- driver                                  -->  BMP picture driver
|   |-- monitor                                 -->  BMP picture monitor
|   |-- pic                                     -->  BMP picture for test
|-- project
|   `-- dk_video.gprj          	                -->  GowinYunYuan Project File for Example Design
|   `-- dk_video.gprj.user                      -->  GowinYunYuan Project File for Example Design
|   |-- impl
|   |   `-- project_process_config.json
|   |   |-- gwsynthesis
|   |   |-- pnr
|   |   |-- synthesize
|   |-- temp                                    
|   |-- src                          
|       `-- video_top.v                         -->  File for GowinYunYuan Project
|       `-- dk_video.cst                        -->  File for GowinYunYuan Project
|       `-- dk_video.gao                        -->  File for GowinYunYuan Project
|       `-- gao.v                               -->  File for GowinYunYuan Project
|       `-- dk_video.sdc                        -->  File for GowinYunYuan Project 
|       |-- dvi_rx_top          
|       |   `-- dvi_rx_top.v                    -->  File for GowinYunYuan Project(Encrypted)
|       |   `-- dvi_rx_top.vo                   -->  File for Simulation
|       |   `-- dvi_rx_top.ipc                  -->  File for GowinYunYuan Project
|       |-- dvi_tx_top          
|       |   `-- dvi_tx_top.v                    -->  File for GowinYunYuan Project(Encrypted)
|       |   `-- dvi_tx_top.vo                   -->  File for Simulation
|       |   `-- dvi_tx_top.ipc                  -->  File for GowinYunYuan Project
|-- simulation                                  -->  Simulation Environment
|   `-- tb_top.do          	                    -->  File for Simulation 
|   `-- tb_top_wave.do                          -->  File for Simulation 

---------------------------------------------------------------------------------------------------------------
HOW TO OPEN A PROJECT IN GowinYunYuan:
---------------------------------------------------------------------------------------------------------------
1. Unzip the respective design files.
2. Launch GowinYunYuan and select "File -> Open -> Project"
3. In the Open Project dialog, enter the Project location -- "project",select the project"dk_video.gprj".
4. Click Finish. Now the project is successfully loaded. 

---------------------------------------------------------------------------------------------------------------
HOW TO RUN SYNTHESIZE, PLACE AND ROUTE, IP CORE GENERATION, AND TIMING ANALYSIS IN GowinYunYuan:
---------------------------------------------------------------------------------------------------------------

1. Click the Process tab in the process panel of the GowinYunYuan dashboard. 
   Double click on Synthsize(Synplify Pro). This will bring the design through synthesis.
2. Click the Process tab in the process panel of the GowinYunYuan dashboard. 
   Double click on Place & Route. This will bring the design through mapping, place and route.
3. Once Place & Route is done, user can double click on Timing Analysis Report to get 
   the timing analysis result.
4. Click on "Project -> Configuration -> Place & Route" to configurate the Post-Place File 
   and SDF File of the design.
----------------------------------------------------------------------------------------------------------------

HOW TO RUN SIMULATION
1. User can run functional simulation by software Modelsim. 
----------------------------------------------------------------------------------------------------------------

HOW TO  GENERATE IP CORE
1. Click the IP Core Generator tab in the Window panel of the GowinYunYuan dashboard.
   Double click on "DVI_TX" and "DVI_RX". This will generate the IP Core for the design.
--------------------------------------------------------------------------------------------------------------

