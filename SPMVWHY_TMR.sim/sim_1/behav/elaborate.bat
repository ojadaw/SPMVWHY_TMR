@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto 67f6c56936d14d3982e39500fbfd780e -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot CSR_TMR_tb_behav xil_defaultlib.CSR_TMR_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
