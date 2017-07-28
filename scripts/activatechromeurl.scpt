FasdUAS 1.101.10   ��   ��    k             l     ��  ��      David Roberts, 29/4/15     � 	 	 .   D a v i d   R o b e r t s ,   2 9 / 4 / 1 5   
  
 l     ��  ��    Y S Opens a passed URL in Chrome, or switches to the relevant tab if it's already open     �   �   O p e n s   a   p a s s e d   U R L   i n   C h r o m e ,   o r   s w i t c h e s   t o   t h e   r e l e v a n t   t a b   i f   i t ' s   a l r e a d y   o p e n      l     ��  ��    N H If a relevant tab is already focused, switches to the next matching tab     �   �   I f   a   r e l e v a n t   t a b   i s   a l r e a d y   f o c u s e d ,   s w i t c h e s   t o   t h e   n e x t   m a t c h i n g   t a b      l     ��������  ��  ��        l     ��  ��    = 7 Function to work out what the frontmost application is     �   n   F u n c t i o n   t o   w o r k   o u t   w h a t   t h e   f r o n t m o s t   a p p l i c a t i o n   i s      i         I      �������� $0 frontmostappname frontmostAppName��  ��    O          L     ! ! c     " # " l    $���� $ 6    % & % n    
 ' ( ' 1    
��
�� 
pnam ( 4   �� )
�� 
pcap ) m    ����  & =    * + * 1    ��
�� 
pisf + m    ��
�� boovtrue��  ��   # m    ��
�� 
ctxt   m      , ,�                                                                                  sevs  alis    �  Macintosh HD               ҆}�H+    �System Events.app                                               �=�2ۇ        ����  	                CoreServices    ҆o�      �2�w      � �: �7  =Macintosh HD:System: Library: CoreServices: System Events.app   $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��     - . - l     ��������  ��  ��   .  / 0 / i     1 2 1 I      �� 3���� 0 activateurl activateURL 3  4 5 4 o      ���� 0 	loctoopen 	locToOpen 5  6�� 6 o      ���� 0 
loctomatch 
locToMatch��  ��   2 k     � 7 7  8 9 8 l     ��������  ��  ��   9  : ; : O     � < = < k    � > >  ? @ ? l   ��������  ��  ��   @  A B A l   �� C D��   C 0 * Check whether the app running and focused    D � E E T   C h e c k   w h e t h e r   t h e   a p p   r u n n i n g   a n d   f o c u s e d B  F G F r     H I H l    J���� J =    K L K n   	 M N M I    	�������� $0 frontmostappname frontmostAppName��  ��   N  f     L m   	 
 O O � P P  G o o g l e   C h r o m e��  ��   I o      ���� 0 
appfocused 
appFocused G  Q R Q Z    S T���� S >    U V U n     W X W 1    ��
�� 
prun X  g     V m    ��
�� boovtrue T I   ������
�� .miscactvnull��� ��� null��  ��  ��  ��   R  Y Z Y l     ��������  ��  ��   Z  [ \ [ l     �� ] ^��   ] ( " Get all the matching tabs we have    ^ � _ _ D   G e t   a l l   t h e   m a t c h i n g   t a b s   w e   h a v e \  ` a ` l     �� b c��   b < 6 Plus the index of the one we're currently on (if any)    c � d d l   P l u s   t h e   i n d e x   o f   t h e   o n e   w e ' r e   c u r r e n t l y   o n   ( i f   a n y ) a  e f e r     $ g h g J     "����   h o      ���� 0 matches   f  i j i r   % ( k l k m   % &����   l o      ���� &0 currentmatchindex currentMatchIndex j  m n m l  ) )��������  ��  ��   n  o p o r   ) , q r q m   ) *����   r o      ���� 0 j   p  s t s X   - � u�� v u k   ? � w w  x y x r   ? B z { z m   ? @����   { o      ���� 0 i   y  | } | r   C H ~  ~ [   C F � � � o   C D���� 0 j   � m   D E����   o      ���� 0 j   }  ��� � X   I � ��� � � k   [ � � �  � � � r   [ ` � � � [   [ ^ � � � o   [ \���� 0 i   � m   \ ]����  � o      ���� 0 i   �  ��� � Z   a � � ����� � E   a f � � � n   a d � � � 1   b d��
�� 
URL  � o   a b���� 0 t   � o   d e���� 0 
loctomatch 
locToMatch � k   i � � �  � � � l  i i�� � ���   � 2 , We have a matching tab - add it to the list    � � � � X   W e   h a v e   a   m a t c h i n g   t a b   -   a d d   i t   t o   t h e   l i s t �  � � � s   i p � � � J   i m � �  � � � o   i j���� 0 j   �  ��� � o   j k���� 0 i  ��   � n       � � �  ;   n o � o   m n���� 0 matches   �  � � � l  q q�� � ���   � 4 . If this tab is focused, set currentMatchIndex    � � � � \   I f   t h i s   t a b   i s   f o c u s e d ,   s e t   c u r r e n t M a t c h I n d e x �  ��� � Z   q � � ����� � =   q } � � � n   q t � � � 1   r t��
�� 
ID   � o   q r���� 0 t   � n   t | � � � 1   z |��
�� 
ID   � n   t z � � � 1   x z��
�� 
acTa � 4  t x�� �
�� 
cwin � m   v w����  � k   � � � �  � � � r   � � � � � l  � � ����� � I  � ��� ���
�� .corecnte****       **** � o   � ����� 0 matches  ��  ��  ��   � o      ���� &0 currentmatchindex currentMatchIndex �  ��� � l  � ��� � ���   � = 7display dialog "current match now " & currentMatchIndex    � � � � n d i s p l a y   d i a l o g   " c u r r e n t   m a t c h   n o w   "   &   c u r r e n t M a t c h I n d e x��  ��  ��  ��  ��  ��  ��  �� 0 t   � l  L O ����� � n   L O � � � 2  M O��
�� 
CrTb � o   L M���� 0 w  ��  ��  ��  �� 0 w   v l  0 3 ����� � 2  0 3��
�� 
cwin��  ��   t  � � � l  � ���������  ��  ��   �  � � � Z   � � � � � � � l  � � ����� � =  � � � � � l  � � ����� � I  � ��� ���
�� .corecnte****       **** � o   � ����� 0 matches  ��  ��  ��   � m   � �����  ��  ��   � k   � � � �  � � � l  � ��� � ���   � . ( If there are no matches, open a new tab    � � � � P   I f   t h e r e   a r e   n o   m a t c h e s ,   o p e n   a   n e w   t a b �  ��� � I  � ��� ���
�� .GURLGURLnull��� ��� TEXT � o   � ����� 0 	loctoopen 	locToOpen��  ��   �  � � � F   � � � � � H   � � � � o   � ����� 0 
appfocused 
appFocused � ?   � � � � � o   � ����� &0 currentmatchindex currentMatchIndex � m   � �����   �  ��� � k   � � � �  � � � l  � �� � ��   � B < We're already on one of these tabs but Chrome isn't focused    � � � � x   W e ' r e   a l r e a d y   o n   o n e   o f   t h e s e   t a b s   b u t   C h r o m e   i s n ' t   f o c u s e d �  � � � l  � ��~ � ��~   � ' ! Just focus and don't change tabs    � � � � B   J u s t   f o c u s   a n d   d o n ' t   c h a n g e   t a b s �  ��} � I  � ��|�{�z
�| .miscactvnull��� ��� null�{  �z  �}  ��   � k   � � � �  � � � l  � ��y � ��y   � ) # Otherwise switch to the next match    � � � � F   O t h e r w i s e   s w i t c h   t o   t h e   n e x t   m a t c h �  � � � r   � � � � � [   � � � � � l  � � ��x�w � `   � � � � � l  � � ��v�u � o   � ��t�t &0 currentmatchindex currentMatchIndex�v  �u   � l  � � ��s�r � I  � ��q ��p
�q .corecnte****       **** � o   � ��o�o 0 matches  �p  �s  �r  �x  �w   � m   � ��n�n  � o      �m�m 0 newmatchindex newMatchIndex �  � � � l  � ��l �l    l fdisplay dialog "" & currentMatchIndex & " -> " & newMatchIndex & "(length " & (count of matches) & ")"    � � d i s p l a y   d i a l o g   " "   &   c u r r e n t M a t c h I n d e x   &   "   - >   "   &   n e w M a t c h I n d e x   &   " ( l e n g t h   "   &   ( c o u n t   o f   m a t c h e s )   &   " ) " �  r   � � n   � � 4   � ��k	
�k 
cobj	 l  � �
�j�i
 o   � ��h�h 0 newmatchindex newMatchIndex�j  �i   o   � ��g�g 0 matches   o      �f�f 0 chosenmatch chosenMatch  r   � � n   � � 4   � ��e
�e 
cobj m   � ��d�d  o   � ��c�c 0 chosenmatch chosenMatch o      �b�b 0 winindex winIndex  r   � � n   � � 4   � ��a
�a 
cobj m   � ��`�`  o   � ��_�_ 0 chosenmatch chosenMatch o      �^�^ 0 tabindex tabIndex  r   � � l  � ��]�\ o   � ��[�[ 0 tabindex tabIndex�]  �\   l     �Z�Y n        1   � ��X
�X 
acTI  4   � ��W!
�W 
cwin! l  � �"�V�U" o   � ��T�T 0 winindex winIndex�V  �U  �Z  �Y   #�S# I  � ��R$�Q
�R .miscactvnull��� ��� null$ 4   � ��P%
�P 
cwin% l  � �&�O�N& o   � ��M�M 0 winindex winIndex�O  �N  �Q  �S   � '�L' l  � ��K�J�I�K  �J  �I  �L   = m     ((�                                                                                  rimZ  alis    h  Macintosh HD               ҆}�H+    Google Chrome.app                                               y�̚��        ����  	                Applications    ҆o�      ̚��        ,Macintosh HD:Applications: Google Chrome.app  $  G o o g l e   C h r o m e . a p p    M a c i n t o s h   H D  Applications/Google Chrome.app  / ��   ; )�H) l  � ��G�F�E�G  �F  �E  �H   0 *+* l     �D�C�B�D  �C  �B  + ,�A, i    -.- I     �@/�?
�@ .aevtoappnull  �   � ****/ o      �>�> 0 argv  �?  . k     400 121 l     �=34�=  3 M Gmy activateURL("http://www.google.com/calendar", "google.com/calendar")   4 �55 � m y   a c t i v a t e U R L ( " h t t p : / / w w w . g o o g l e . c o m / c a l e n d a r " ,   " g o o g l e . c o m / c a l e n d a r " )2 676 l     �<89�<  8  return   9 �::  r e t u r n7 ;<; Z    =>�;�:= A     ?@? l    A�9�8A I    �7B�6
�7 .corecnte****       ****B o     �5�5 0 argv  �6  �9  �8  @ m    �4�4 > L   
 CC m   
 DD �EE � E r r o r :   P a s s   t h e   U R L   y o u   w a n t   t o   o p e n   t o   t h i s   s c r i p t   a s   a n   a r g u m e n t�;  �:  < FGF Z    &HI�3�2H A    JKJ l   L�1�0L I   �/M�.
�/ .corecnte****       ****M o    �-�- 0 argv  �.  �1  �0  K m    �,�, I s    "NON n    PQP 4    �+R
�+ 
cobjR m    �*�* Q o    �)�) 0 argv  O l     S�(�'S n      TUT  ;     !U l    V�&�%V o     �$�$ 0 argv  �&  �%  �(  �'  �3  �2  G W�#W n  ' 4XYX I   ( 4�"Z�!�" 0 activateurl activateURLZ [\[ n   ( ,]^] 4   ) ,� _
�  
cobj_ m   * +�� ^ o   ( )�� 0 argv  \ `�` n   , 0aba 4   - 0�c
� 
cobjc m   . /�� b o   , -�� 0 argv  �  �!  Y  f   ' (�#  �A       �defg�  d ���� $0 frontmostappname frontmostAppName� 0 activateurl activateURL
� .aevtoappnull  �   � ****e � ��hi�� $0 frontmostappname frontmostAppName�  �  h  i  ,��j��
� 
pcap
� 
pnamj  
� 
pisf
� 
ctxt� � *�k/�,�[�,\Ze81�&Uf � 2��kl�
� 0 activateurl activateURL� �	m�	 m  ��� 0 	loctoopen 	locToOpen� 0 
loctomatch 
locToMatch�  k ������� ������������� 0 	loctoopen 	locToOpen� 0 
loctomatch 
locToMatch� 0 
appfocused 
appFocused� 0 matches  � &0 currentmatchindex currentMatchIndex� 0 j  �  0 w  �� 0 i  �� 0 t  �� 0 newmatchindex newMatchIndex�� 0 chosenmatch chosenMatch�� 0 winindex winIndex�� 0 tabindex tabIndexl (�� O���������������������������� $0 frontmostappname frontmostAppName
�� 
prun
�� .miscactvnull��� ��� null
�� 
cwin
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� 
CrTb
�� 
URL 
�� 
ID  
�� 
acTa
�� .GURLGURLnull��� ��� TEXT
�� 
bool
�� 
acTI�
 �� �)j+ � E�O*�,e 
*j Y hOjvE�OjE�OjE�O m*�-[��l kh jE�O�kE�O L��-[��l kh �kE�O��,� )��lv�6GO��,*�k/�,�,  �j E�OPY hY h[OY��[OY��O�j j  
�j Y I�	 �j�& 
*j Y 4��j #kE�O��/E�O��k/E�O��l/E�O�*�/�,FO*�/j OPUOPg ��.����no��
�� .aevtoappnull  �   � ****�� 0 argv  ��  n ���� 0 argv  o ��D����
�� .corecnte****       ****
�� 
cobj�� 0 activateurl activateURL�� 5�j  k �Y hO�j  l ��k/�6GY hO)��k/��l/l+ ascr  ��ޭ