FasdUAS 1.101.10   ��   ��    k             l     ��������  ��  ��        l     ��������  ��  ��     	 
 	 i        I      �� ���� 0 replacetext replaceText      o      ���� 0 sometext someText      o      ���� 0 olditem oldItem   ��  o      ���� 0 newitem newItem��  ��    k     a       l      ��  ��   ^X
     replace all occurances of oldItem with newItem
          parameters -     someText [text]: the text containing the item(s) to change
                    oldItem [text, list of text]: the item to be replaced
                    newItem [text]: the item to replace with
          returns [text]:     the text with the item(s) replaced
          �  � 
           r e p l a c e   a l l   o c c u r a n c e s   o f   o l d I t e m   w i t h   n e w I t e m 
                     p a r a m e t e r s   -           s o m e T e x t   [ t e x t ] :   t h e   t e x t   c o n t a i n i n g   t h e   i t e m ( s )   t o   c h a n g e 
                                         o l d I t e m   [ t e x t ,   l i s t   o f   t e x t ] :   t h e   i t e m   t o   b e   r e p l a c e d 
                                         n e w I t e m   [ t e x t ] :   t h e   i t e m   t o   r e p l a c e   w i t h 
                     r e t u r n s   [ t e x t ] :           t h e   t e x t   w i t h   t h e   i t e m ( s )   r e p l a c e d 
                r         J            n       !   1    ��
�� 
txdl ! 1     ��
�� 
ascr   "�� " o    ���� 0 olditem oldItem��    J       # #  $ % $ o      ���� 0 temptid tempTID %  &�� & n      ' ( ' 1    ��
�� 
txdl ( 1    ��
�� 
ascr��     ) * ) Q    ^ + , - + k    J . .  / 0 / r    2 1 2 1 J    ! 3 3  4 5 4 n     6 7 6 2   ��
�� 
citm 7 o    ���� 0 sometext someText 5  8�� 8 o    ���� 0 newitem newItem��   2 J       9 9  : ; : o      ���� 0 itemlist itemList ;  <�� < n      = > = 1   . 0��
�� 
txdl > 1   - .��
�� 
ascr��   0  ?�� ? r   3 J @ A @ J   3 9 B B  C D C c   3 6 E F E o   3 4���� 0 itemlist itemList F m   4 5��
�� 
ctxt D  G�� G o   6 7���� 0 temptid tempTID��   A J       H H  I J I o      ���� 0 sometext someText J  K�� K n      L M L 1   F H��
�� 
txdl M 1   E F��
�� 
ascr��  ��   , R      �� N O
�� .ascrerr ****      � **** N o      ���� 0 errormessage errorMessage O �� P��
�� 
errn P o      ���� 0 errornumber errorNumber��   - l  R ^ Q R S Q k   R ^ T T  U V U r   R W W X W o   R S���� 0 temptid tempTID X n      Y Z Y 1   T V��
�� 
txdl Z 1   S T��
�� 
ascr V  [�� [ l  X ^ \ ] ^ \ R   X ^�� _ `
�� .ascrerr ****      � **** _ o   \ ]���� 0 errormessage errorMessage ` �� a��
�� 
errn a o   Z [���� 0 errornumber errorNumber��   ]   pass it on    ^ � b b    p a s s   i t   o n��   R   oops    S � c c 
   o o p s *  d e d l  _ _��������  ��  ��   e  f�� f L   _ a g g o   _ `���� 0 sometext someText��   
  h i h l     ��������  ��  ��   i  j k j i     l m l I     �� n��
�� .aevtoappnull  �   � **** n o      ���� 0 argv  ��   m k     � o o  p q p Z     r s���� r A      t u t l     v���� v I    �� w��
�� .corecnte****       **** w o     ���� 0 argv  ��  ��  ��   u m    ����  s L   
  x x m   
  y y � z z � E r r o r :   P a s s   t h e   p a t h   y o u   w a n t   t o   o p e n   t o   t h i s   s c r i p t   a s   a n   a r g u m e n t��  ��   q  { | { l   ��������  ��  ��   |  } ~ } r      �  n     � � � 4    �� �
�� 
cobj � m    ����  � o    ���� 0 argv   � o      ���� 
0 mypath   ~  � � � l   �� � ���   � F @set mypath to "/Users/david/Dropbox/Coca-Cola Enterprises/Admin"    � � � � � s e t   m y p a t h   t o   " / U s e r s / d a v i d / D r o p b o x / C o c a - C o l a   E n t e r p r i s e s / A d m i n " �  � � � r     � � � m     � � � � � * / U s e r s / d a v i d / D r o p b o x / � o      ���� 0 reqpath   �  � � � r     � � � m     � � � � �  Z : \ � o      ���� 0 destpath   �  � � � r     # � � � m     ! � � � � � ` / U s e r s / d a v i d / V i r t u a l   M a c h i n e s / s h a r e d / c o m m a n d . a h k � o      ���� "0 commandfilepath commandFilePath �  � � � l  $ $��������  ��  ��   �  � � � l  $ $�� � ���   � 5 / Check the path is within the reqpath directory    � � � � ^   C h e c k   t h e   p a t h   i s   w i t h i n   t h e   r e q p a t h   d i r e c t o r y �  � � � r   $ ) � � � m   $ % � � � � �   � n      � � � 1   & (��
�� 
txdl � 1   % &��
�� 
ascr �  � � � r   * = � � � c   * 9 � � � n   * 7 � � � 7 + 7�� � �
�� 
cha  � m   / 1����  � l  2 6 ����� � n   2 6 � � � 1   4 6��
�� 
leng � o   2 4���� 0 reqpath  ��  ��   � o   * +���� 
0 mypath   � m   7 8��
�� 
TEXT � o      ���� 0 startstr   �  � � � Z   > \ � ����� � >  > C � � � o   > A���� 0 startstr   � o   A B���� 0 reqpath   � k   F X � �  � � � I  F M�� ���
�� .sysodlogaskr        TEXT � m   F I � � � � �  I n v a l i d   f i l e��   �  ��� � R   N X���� �
�� .ascrerr ****      � ****��   � �� ���
�� 
errn � m   R U��������  ��  ��  ��   �  � � � l  ] ]��������  ��  ��   �  � � � l  ] ]�� � ���   � E ? Translate the path into the equivalent place in the windows VM    � � � � ~   T r a n s l a t e   t h e   p a t h   i n t o   t h e   e q u i v a l e n t   p l a c e   i n   t h e   w i n d o w s   V M �  � � � r   ] t � � � c   ] p � � � n   ] n � � � 7 ^ n�� � �
�� 
cha  � l  b h ����� � [   b h � � � l  c f ����� � n   c f � � � 1   d f��
�� 
leng � o   c d���� 0 reqpath  ��  ��   � m   f g���� ��  ��   � l  i m ����� � l  i m ����� � n   i m � � � 1   k m��
�� 
leng � o   i k���� 
0 mypath  ��  ��  ��  ��   � o   ] ^�� 
0 mypath   � m   n o�~
�~ 
TEXT � o      �}�} 
0 endstr   �  � � � r   u � � � � b   u � � � � b   u z � � � m   u x � � � � � 
 R u n ,   � o   x y�|�| 0 destpath   � I   z ��{ ��z�{ 0 replacetext replaceText �  � � � o   { ~�y�y 
0 endstr   �  � � � m   ~ � � � � � �  / �  ��x � m   � � � � � � �  \�x  �z   � o      �w�w 0 command   �  � � � l  � ��v�u�t�v  �u  �t   �  � � � l  � ��s � ��s   �   Write the path to file    � � � � .   W r i t e   t h e   p a t h   t o   f i l e �  � � � r   � � � � � c   � �   l  � ��r�q 4   � ��p
�p 
psxf o   � ��o�o "0 commandfilepath commandFilePath�r  �q   m   � ��n
�n 
TEXT � o      �m�m  0 outputfilepath outputFilePath �  r   � � I  � ��l	
�l .rdwropenshor       file o   � ��k�k  0 outputfilepath outputFilePath	 �j
�i
�j 
perm
 m   � ��h
�h boovtrue�i   o      �g�g 	0 fileh    I  � ��f
�f .rdwrseofnull���     **** o   � ��e�e 	0 fileh   �d�c
�d 
set2 m   � ��b�b  �c    I  � ��a
�a .rdwrwritnull���     **** o   � ��`�` 0 command   �_
�_ 
refn o   � ��^�^ 	0 fileh   �]�\
�] 
as   m   � ��[
�[ 
TEXT�\    I  � ��Z�Y
�Z .rdwrclosnull���     **** o   � ��X�X 	0 fileh  �Y    l  � ��W�V�U�W  �V  �U    l  � ��T�T     Switch to Windows    �   $   S w i t c h   t o   W i n d o w s !�S! O  � �"#" I  � ��R�Q�P
�R .miscactvnull��� ��� null�Q  �P  # m   � �$$�                                                                                      @ alis    h  Macintosh HD               ̩��H+   �N VMware Fusion.app                                               �J�Й��        ����  	                Applications    ̩��      ЙϾ     �N   ,Macintosh HD:Applications: VMware Fusion.app  $  V M w a r e   F u s i o n . a p p    M a c i n t o s h   H D  Applications/VMware Fusion.app  / ��  �S   k %�O% l     �N�M�L�N  �M  �L  �O       �K&'(�K  & �J�I�J 0 replacetext replaceText
�I .aevtoappnull  �   � ****' �H �G�F)*�E�H 0 replacetext replaceText�G �D+�D +  �C�B�A�C 0 sometext someText�B 0 olditem oldItem�A 0 newitem newItem�F  ) �@�?�>�=�<�;�:�@ 0 sometext someText�? 0 olditem oldItem�> 0 newitem newItem�= 0 temptid tempTID�< 0 itemlist itemList�; 0 errormessage errorMessage�: 0 errornumber errorNumber* �9�8�7�6�5�4,�3
�9 
ascr
�8 
txdl
�7 
cobj
�6 
citm
�5 
ctxt�4 0 errormessage errorMessage, �2�1�0
�2 
errn�1 0 errornumber errorNumber�0  
�3 
errn�E b��,�lvE[�k/E�Z[�l/��,FZO 4��-�lvE[�k/E�Z[�l/��,FZO��&�lvE[�k/E�Z[�l/��,FZW X  ���,FO)�l�O�( �/ m�.�--.�,
�/ .aevtoappnull  �   � ****�. 0 argv  �-  - �+�+ 0 argv  . )�* y�)�( ��' ��& ��% ��$�#�"�!� � ����� � � ���������������$�
�* .corecnte****       ****
�) 
cobj�( 
0 mypath  �' 0 reqpath  �& 0 destpath  �% "0 commandfilepath commandFilePath
�$ 
ascr
�# 
txdl
�" 
cha 
�! 
leng
�  
TEXT� 0 startstr  
� .sysodlogaskr        TEXT
� 
errn���� 
0 endstr  � 0 replacetext replaceText� 0 command  
� 
psxf�  0 outputfilepath outputFilePath
� 
perm
� .rdwropenshor       file� 	0 fileh  
� 
set2
� .rdwrseofnull���     ****
� 
refn
� 
as  � 
� .rdwrwritnull���     ****
� .rdwrclosnull���     ****
� .miscactvnull��� ��� null�, �j  k �Y hO��k/E�O�E�O�E�O�E�O���,FO�[�\[Zk\Z��,2�&E` O_ � a j O)a a lhY hO�[�\[Z��,k\Z��,2�&E` Oa �%*_ a a m+ %E` O*a �/�&E` O_ a el E` O_ a  jl !O_ a "_ a #�a $ %O_ j &Oa ' *j (U ascr  ��ޭ