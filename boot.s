//BOOTSTRAP

.set ALIGN,    1<<0  // ALINHA MODULOS CARREGADOS NOS LIMITES DA PAGINA
.set MEMINFO,  1<<1  // FORNECE MAPA DE MEMORIA
.set FLAGS,    ALIGN | MEMINFO  // CAMPO 'FLAG' DO MULTIBOOT
.set MAGIC,    0x1BADB002  //NUMERO MAGICO QUE PERMITE QUE O BOOTLOADER ENCONTRE O CABECALHO
.set CHECKSUM, -(MAGIC + FLAGS)  //CHECKSUM PARA PROVAR QUE EH O MULTIBOOT

//HEADER DO MULTIBOOT
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

.section .bss
.align 16
stack_bottom:
	.skip 16384
stack_top:
.section .text
.global _start
.type _start, @function
_start:
	mov $stack_top, %esp
	call kernel_main
	cli
1:      hlt
	jmp 1b

.size _start, . - _start

