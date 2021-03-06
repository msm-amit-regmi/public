					ORG		$3000

					EXPORT	YM2203_PLAY
					EXPORT	YM2203_STOP
					EXPORT	FEEDBACK
					EXPORT	CONNECT
					EXPORT	MULTI

YM2203_PLAY
					BRA		REAL_YM2203_PLAY

FEEDBACK			FCB		1
MULTI				FCB		1
CONNECT				FCB		7



REAL_YM2203_PLAY	PSHS	A,B,X,Y,U,CC,DP

					LEAY	SAMPLEDATA,PCR
					LDX		#SAMPLEDATA_END-SAMPLEDATA

WRITE_LOOP			LDA		,Y
					BNE		WRITE_LOOP_NEXT ; Sample is taken from FM TOWNS. No 4th to 6th channels.

					LDD		1,Y
					CMPA	#$31
					BNE		WRITE_LOOP_WRITE
					ANDB	#$F0
					ORB		MULTI,PCR
WRITE_LOOP_WRITE
					BSR		YM2203_WRITE
WRITE_LOOP_NEXT
					LEAY	3,Y
					LEAX	-3,X
					BNE		WRITE_LOOP


					LDD		#$4000
					BSR		YM2203_WRITE
					LDD		#$447F
					BSR		YM2203_WRITE
					LDD		#$487F
					BSR		YM2203_WRITE
					LDD		#$4C7F
					BSR		YM2203_WRITE

					LDA		#$B1
					LDB		FEEDBACK,PCR
					LSLB
					LSLB
					LSLB
					ORB		CONNECT,PCR
					BSR		YM2203_WRITE


					LDD		#$28F1			; START TONE
					BSR		YM2203_WRITE


					PULS	A,B,X,Y,U,CC,DP,PC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

YM2203_STOP			PSHS	A,B
					LDD		#$2801			; STOP TONE
					BSR		YM2203_WRITE
					PULS	A,B,PC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

YM2203COM			EQU		$FD15
YM2203DAT			EQU		$FD16

; A reg   B data
YM2203_WRITE		PSHS	A
					BSR		YM2203_WAIT_READY
					PULS	A

					STA		YM2203DAT
					LDA		#3			; Latch register number
					STA		YM2203COM
					CLR		YM2203COM

					STB		YM2203DAT
					LDA		#2			; Write
					STA		YM2203COM
					CLR		YM2203COM

					RTS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

YM2203_WAIT_READY	LDA		#4			; Get Status
					STA		YM2203COM
					LDA		YM2203DAT
					CLR		YM2203COM
					TSTA
					BMI		YM2203_WAIT_READY
					RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


SAMPLEDATA
					FCB		0x00,0x30,0x01
					FCB		0x00,0x34,0x01
					FCB		0x00,0x38,0x01
					FCB		0x00,0x3C,0x01
					FCB		0x00,0x40,0x7F
					FCB		0x00,0x44,0x7F
					FCB		0x00,0x48,0x7F
					FCB		0x00,0x4C,0x7F
					FCB		0x00,0x50,0x1F
					FCB		0x00,0x54,0x1F
					FCB		0x00,0x58,0x1F
					FCB		0x00,0x5C,0x1F
					FCB		0x00,0x60,0x00
					FCB		0x00,0x64,0x00
					FCB		0x00,0x68,0x00
					FCB		0x00,0x6C,0x00
					FCB		0x00,0x70,0x00
					FCB		0x00,0x74,0x00
					FCB		0x00,0x78,0x00
					FCB		0x00,0x7C,0x00
					FCB		0x00,0x80,0x0F
					FCB		0x00,0x84,0x0F
					FCB		0x00,0x88,0x0F
					FCB		0x00,0x8C,0x0F
					FCB		0x00,0xB0,0x17
					FCB		0x00,0xB4,0xC0
					FCB		0x00,0x31,0x01
					FCB		0x00,0x35,0x01
					FCB		0x00,0x39,0x01
					FCB		0x00,0x3D,0x01
					FCB		0x00,0x41,0x7F
					FCB		0x00,0x45,0x7F
					FCB		0x00,0x49,0x7F
					FCB		0x00,0x4D,0x7F
					FCB		0x00,0x51,0x1F
					FCB		0x00,0x55,0x1F
					FCB		0x00,0x59,0x1F
					FCB		0x00,0x5D,0x1F
					FCB		0x00,0x61,0x00
					FCB		0x00,0x65,0x00
					FCB		0x00,0x69,0x00
					FCB		0x00,0x6D,0x00
					FCB		0x00,0x71,0x00
					FCB		0x00,0x75,0x00
					FCB		0x00,0x79,0x00
					FCB		0x00,0x7D,0x00
					FCB		0x00,0x81,0x0F
					FCB		0x00,0x85,0x0F
					FCB		0x00,0x89,0x0F
					FCB		0x00,0x8D,0x0F
					FCB		0x00,0xB1,0x17
					FCB		0x00,0xB5,0xC0
					FCB		0x00,0x32,0x01
					FCB		0x00,0x36,0x01
					FCB		0x00,0x3A,0x01
					FCB		0x00,0x3E,0x01
					FCB		0x00,0x42,0x7F
					FCB		0x00,0x46,0x7F
					FCB		0x00,0x4A,0x7F
					FCB		0x00,0x4E,0x7F
					FCB		0x00,0x52,0x1F
					FCB		0x00,0x56,0x1F
					FCB		0x00,0x5A,0x1F
					FCB		0x00,0x5E,0x1F
					FCB		0x00,0x62,0x00
					FCB		0x00,0x66,0x00
					FCB		0x00,0x6A,0x00
					FCB		0x00,0x6E,0x00
					FCB		0x00,0x72,0x00
					FCB		0x00,0x76,0x00
					FCB		0x00,0x7A,0x00
					FCB		0x00,0x7E,0x00
					FCB		0x00,0x82,0x0F
					FCB		0x00,0x86,0x0F
					FCB		0x00,0x8A,0x0F
					FCB		0x00,0x8E,0x0F
					FCB		0x00,0xB2,0x17
					FCB		0x00,0xB6,0xC0
					FCB		0x03,0x30,0x01
					FCB		0x03,0x34,0x01
					FCB		0x03,0x38,0x01
					FCB		0x03,0x3C,0x01
					FCB		0x03,0x40,0x7F
					FCB		0x03,0x44,0x7F
					FCB		0x03,0x48,0x7F
					FCB		0x03,0x4C,0x7F
					FCB		0x03,0x50,0x1F
					FCB		0x03,0x54,0x1F
					FCB		0x03,0x58,0x1F
					FCB		0x03,0x5C,0x1F
					FCB		0x03,0x60,0x00
					FCB		0x03,0x64,0x00
					FCB		0x03,0x68,0x00
					FCB		0x03,0x6C,0x00
					FCB		0x03,0x70,0x00
					FCB		0x03,0x74,0x00
					FCB		0x03,0x78,0x00
					FCB		0x03,0x7C,0x00
					FCB		0x03,0x80,0x0F
					FCB		0x03,0x84,0x0F
					FCB		0x03,0x88,0x0F
					FCB		0x03,0x8C,0x0F
					FCB		0x03,0xB0,0x17
					FCB		0x03,0xB4,0xC0
					FCB		0x03,0x31,0x01
					FCB		0x03,0x35,0x01
					FCB		0x03,0x39,0x01
					FCB		0x03,0x3D,0x01
					FCB		0x03,0x41,0x7F
					FCB		0x03,0x45,0x7F
					FCB		0x03,0x49,0x7F
					FCB		0x03,0x4D,0x7F
					FCB		0x03,0x51,0x1F
					FCB		0x03,0x55,0x1F
					FCB		0x03,0x59,0x1F
					FCB		0x03,0x5D,0x1F
					FCB		0x03,0x61,0x00
					FCB		0x03,0x65,0x00
					FCB		0x03,0x69,0x00
					FCB		0x03,0x6D,0x00
					FCB		0x03,0x71,0x00
					FCB		0x03,0x75,0x00
					FCB		0x03,0x79,0x00
					FCB		0x03,0x7D,0x00
					FCB		0x03,0x81,0x0F
					FCB		0x03,0x85,0x0F
					FCB		0x03,0x89,0x0F
					FCB		0x03,0x8D,0x0F
					FCB		0x03,0xB1,0x17
					FCB		0x03,0xB5,0xC0
					FCB		0x03,0x32,0x01
					FCB		0x03,0x36,0x01
					FCB		0x03,0x3A,0x01
					FCB		0x03,0x3E,0x01
					FCB		0x03,0x42,0x7F
					FCB		0x03,0x46,0x7F
					FCB		0x03,0x4A,0x7F
					FCB		0x03,0x4E,0x7F
					FCB		0x03,0x52,0x1F
					FCB		0x03,0x56,0x1F
					FCB		0x03,0x5A,0x1F
					FCB		0x03,0x5E,0x1F
					FCB		0x03,0x62,0x00
					FCB		0x03,0x66,0x00
					FCB		0x03,0x6A,0x00
					FCB		0x03,0x6E,0x00
					FCB		0x03,0x72,0x00
					FCB		0x03,0x76,0x00
					FCB		0x03,0x7A,0x00
					FCB		0x03,0x7E,0x00
					FCB		0x03,0x82,0x0F
					FCB		0x03,0x86,0x0F
					FCB		0x03,0x8A,0x0F
					FCB		0x03,0x8E,0x0F
					FCB		0x03,0xB2,0x17
					FCB		0x03,0xB6,0xC0

					FCB		0x00,0xA5,0x22
					FCB		0x00,0xA1,0x6B
					FCB		0x00,0x41,0x08
					FCB		0x00,0x45,0x7E
					FCB		0x00,0x49,0x7E
					FCB		0x00,0x4D,0x7E
					FCB		0x00,0x81,0x0F
					FCB		0x00,0x85,0x0F
					FCB		0x00,0x89,0x0F
					FCB		0x00,0x8D,0x0F
					FCB		0x00,0x28,0x01
					FCB		0x00,0x81,0x0F
					FCB		0x00,0x85,0x0F
					FCB		0x00,0x89,0x0F
					FCB		0x00,0x8D,0x0F
SAMPLEDATA_END
