FasdUAS 1.101.10   ��   ��    k             l     ��  ��    1 + Work out what the frontmost application is     � 	 	 V   W o r k   o u t   w h a t   t h e   f r o n t m o s t   a p p l i c a t i o n   i s   
  
 l     ����  O         k           r        c        l    ����  6       n    
    1    
��
�� 
pnam  4   �� 
�� 
pcap  m    ����   =       1    ��
�� 
pisf  m    ��
�� boovtrue��  ��    m    ��
�� 
ctxt  o      ���� 0 appname appName   ��  l   ��   ��     display dialog appName      � ! ! , d i s p l a y   d i a l o g   a p p N a m e��    m      " "�                                                                                  sevs  alis    �  Macintosh HD               զdH+     /System Events.app                                               _���        ����  	                CoreServices    զG�      ���       /   .   -  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  ��  ��     # $ # l     �� % &��   % + %set appName to "Microsoft PowerPoint"    & � ' ' J s e t   a p p N a m e   t o   " M i c r o s o f t   P o w e r P o i n t " $  ( ) ( l     ��������  ��  ��   )  * + * l     �� , -��   , ; 5 Get the url of the file of the frontmost application    - � . . j   G e t   t h e   u r l   o f   t h e   f i l e   o f   t h e   f r o n t m o s t   a p p l i c a t i o n +  / 0 / l    1���� 1 r     2 3 2 m     4 4 � 5 5   3 o      ���� 0 filepath filePath��  ��   0  6 7 6 l   � 8���� 8 Z    � 9 : ;�� 9 =   " < = < o     ���� 0 appname appName = m     ! > > � ? ?  F i n d e r : O   % 3 @ A @ r   ) 2 B C B l  ) 0 D���� D n   ) 0 E F E 1   . 0��
�� 
psxp F l  ) . G���� G c   ) . H I H l  ) , J���� J 1   ) ,��
�� 
sele��  ��   I m   , -��
�� 
alis��  ��  ��  ��   C o      ���� 0 filepath filePath A m   % & K K�                                                                                  MACS  alis    t  Macintosh HD               զdH+     /
Finder.app                                                      ����~        ����  	                CoreServices    զG�      ��o�       /   .   -  6Macintosh HD:System: Library: CoreServices: Finder.app   
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��   ;  L M L =  6 9 N O N o   6 7���� 0 appname appName O m   7 8 P P � Q Q ( M i c r o s o f t   P o w e r P o i n t M  R S R k   < X T T  U V U O   < P W X W r   @ O Y Z Y c   @ K [ \ [ n   @ I ] ^ ] 1   E I��
�� 
fNam ^ 1   @ E��
�� 
AAPr \ m   I J��
�� 
alis Z o      ���� 0 thepath   X m   < = _ _�                                                                                  PPT3  alis    �  Macintosh HD               զdH+     OMicrosoft PowerPoint.app                                       Ŧ�3ې        ����  	                Applications    զG�      �3̀       O  3Macintosh HD:Applications: Microsoft PowerPoint.app   2  M i c r o s o f t   P o w e r P o i n t . a p p    M a c i n t o s h   H D  %Applications/Microsoft PowerPoint.app   / ��   V  `�� ` r   Q X a b a n   Q V c d c 1   T V��
�� 
psxp d o   Q T���� 0 thepath   b o      ���� 0 filepath filePath��   S  e f e =  [ ` g h g o   [ \���� 0 appname appName h m   \ _ i i � j j  M i c r o s o f t   E x c e l f  k�� k k   c � l l  m n m O   c y o p o r   i x q r q c   i t s t s n   i r u v u 1   n r��
�� 
1773 v 1   i n��
�� 
1172 t m   r s��
�� 
alis r o      ���� 0 thepath   p m   c f w w�                                                                                  XCEL  alis    p  Macintosh HD               զdH+     OMicrosoft Excel.app                                            �0��3ې        ����  	                Applications    զG�      �3̀       O  .Macintosh HD:Applications: Microsoft Excel.app  (  M i c r o s o f t   E x c e l . a p p    M a c i n t o s h   H D   Applications/Microsoft Excel.app  / ��   n  x�� x r   z � y z y n   z  { | { 1   } ��
�� 
psxp | o   z }���� 0 thepath   z o      ���� 0 filepath filePath��  ��  ��  ��  ��   7  } ~ } l     ��������  ��  ��   ~   �  l     �� � ���   �    Open that file in windows    � � � � 4   O p e n   t h a t   f i l e   i n   w i n d o w s �  ��� � l  � � ����� � Z   � � � ����� � >  � � � � � o   � ����� 0 filepath filePath � m   � � � � � � �   � k   � � � �  � � � r   � � � � � n   � � � � � 1   � ���
�� 
psxp � m   � � � � � � � ( O p e n   i n   W i n d o w s . s c p t � o      ���� 0 
scriptpath 
scriptPath �  ��� � I  � ��� � �
�� .sysodsct****        scpt � o   � ����� 0 
scriptpath 
scriptPath � �� ���
�� 
plst � J   � � � �  ��� � o   � ����� 0 filepath filePath��  ��  ��  ��  ��  ��  ��  ��       �� � ���   � ��
�� .aevtoappnull  �   � **** � �� ����� � ���
�� .aevtoappnull  �   � **** � k     � � �  
 � �  / � �  6 � �  �����  ��  ��   �   �  "���� ������� 4�� > K������ P _������ i w���� � �������
�� 
pcap
�� 
pnam �  
�� 
pisf
�� 
ctxt�� 0 appname appName�� 0 filepath filePath
�� 
sele
�� 
alis
�� 
psxp
�� 
AAPr
�� 
fNam�� 0 thepath  
�� 
1172
�� 
1773�� 0 
scriptpath 
scriptPath
�� 
plst
�� .sysodsct****        scpt�� �� *�k/�,�[�,\Ze81�&E�OPUO�E�O��  � *�,�&�,E�UY Q��  !� *a ,a ,�&E` UO_ �,E�Y ,�a   #a  *a ,a ,�&E` UO_ �,E�Y hO�a  a �,E` O_ a �kvl Y h ascr  ��ޭ