FasdUAS 1.101.10   ��   ��    l   = ����  O    =    k   <     	  I   	������
�� .miscactvnull��� ��� obj ��  ��   	  
  
 r   
     m   
 �����  o      ���� 	0 win_w        r        m    �����  o      ���� 	0 win_h        r        m    ����,  o      ���� 0 
name_col_w        l   ��������  ��  ��        l   ��  ��     tell front window     �   " t e l l   f r o n t   w i n d o w      r    9     n     ! " ! 1    ��
�� 
pbnd " 4   �� #
�� 
cwin # m    ����    J       $ $  % & % o      ���� 0 start_h   &  ' ( ' o      ���� 0 start_v   (  ) * ) o      ���� 	0 end_h   *  +�� + o      ���� 0 endv  ��     , - , r   : K . / . J   : D 0 0  1 2 1 o   : ;���� 0 start_h   2  3 4 3 o   ; <���� 0 start_v   4  5 6 5 [   < ? 7 8 7 o   < =���� 0 start_h   8 o   = >���� 	0 win_w   6  9�� 9 [   ? B : ; : o   ? @���� 0 start_v   ; o   @ A���� 	0 win_h  ��   / n       < = < 1   H J��
�� 
pbnd = 4  D H�� >
�� 
cwin > m   F G����  -  ? @ ? l  L L��������  ��  ��   @  A B A r   L X C D C n   L T E F E m   P T��
�� 
lvop F 4  L P�� G
�� 
cwin G m   N O����  D o      ���� 0 options   B  H I H l  Y Y�� J K��   J A ;display dialog (visible of third column of options) as text    K � L L v d i s p l a y   d i a l o g   ( v i s i b l e   o f   t h i r d   c o l u m n   o f   o p t i o n s )   a s   t e x t I  M N M l  Y Y��������  ��  ��   N  O P O r   Y t Q R Q 6  Y p S T S n   Y a U V U 4  \ a�� W
�� 
lvcl W m   _ `����  V o   Y \���� 0 options   T =  d o X Y X 1   e i��
�� 
pnam Y m   j n��
�� elsvelsn R o      ���� 0 name_col   P  Z [ Z r   u � \ ] \ 6  u � ^ _ ^ n   u } ` a ` 4  x }�� b
�� 
lvcl b m   { |����  a o   u x���� 0 options   _ =  � � c d c 1   � ���
�� 
pnam d m   � ���
�� elsvelsm ] o      ���� 0 mod_col   [  e f e r   � � g h g 6  � � i j i n   � � k l k 4  � ��� m
�� 
lvcl m m   � �����  l o   � ����� 0 options   j =  � � n o n 1   � ���
�� 
pnam o m   � ���
�� elsvelss h o      ���� 0 size_col   f  p q p r   � � r s r 6  � � t u t n   � � v w v 4  � ��� x
�� 
lvcl x m   � �����  w o   � ����� 0 options   u =  � � y z y 1   � ���
�� 
pnam z m   � ���
�� elsvelsk s o      ���� 0 kind_col   q  { | { l  � ���������  ��  ��   |  } ~ } l  � ���  ���    Q Kdisplay dialog "Widths: " & (width of name_col) & ", " & (width of mod_col)    � � � � � d i s p l a y   d i a l o g   " W i d t h s :   "   &   ( w i d t h   o f   n a m e _ c o l )   &   " ,   "   &   ( w i d t h   o f   m o d _ c o l ) ~  � � � l  � ��� � ���   � ) #set old_w_name to width of name_col    � � � � F s e t   o l d _ w _ n a m e   t o   w i d t h   o f   n a m e _ c o l �  � � � l  � ��� � ���   � ' !set old_w_mod to width of mod_col    � � � � B s e t   o l d _ w _ m o d   t o   w i d t h   o f   m o d _ c o l �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � 8 2set width of name_col to minimum width of name_col    � � � � d s e t   w i d t h   o f   n a m e _ c o l   t o   m i n i m u m   w i d t h   o f   n a m e _ c o l �  � � � l  � ��� � ���   � 6 0set width of mod_col to minimum width of mod_col    � � � � ` s e t   w i d t h   o f   m o d _ c o l   t o   m i n i m u m   w i d t h   o f   m o d _ c o l �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � % set visible of mod_col to false    � � � � > s e t   v i s i b l e   o f   m o d _ c o l   t o   f a l s e �  � � � l  � ��� � ���   � 5 /set width of name_col to old_w_name + old_w_mod    � � � � ^ s e t   w i d t h   o f   n a m e _ c o l   t o   o l d _ w _ n a m e   +   o l d _ w _ m o d �  � � � l  � ��� � ���   � , &set width of mod_col to old_w_mod + 10    � � � � L s e t   w i d t h   o f   m o d _ c o l   t o   o l d _ w _ m o d   +   1 0 �  � � � l  � ��� � ���   � Q Kdisplay dialog "Widths: " & (width of name_col) & ", " & (width of mod_col)    � � � � � d i s p l a y   d i a l o g   " W i d t h s :   "   &   ( w i d t h   o f   n a m e _ c o l )   &   " ,   "   &   ( w i d t h   o f   m o d _ c o l ) �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   � : 4display dialog sidebar width of front window as text    � � � � h d i s p l a y   d i a l o g   s i d e b a r   w i d t h   o f   f r o n t   w i n d o w   a s   t e x t �  � � � l  � ��� � ���   � = 7display dialog start_h & ", " & start_h + win_w as text    � � � � n d i s p l a y   d i a l o g   s t a r t _ h   &   " ,   "   &   s t a r t _ h   +   w i n _ w   a s   t e x t �  � � � l  � ���������  ��  ��   �  � � � l  � ��� � ���   �  set col to kind_col    � � � � & s e t   c o l   t o   k i n d _ c o l �  � � � l  � ��� � ���   � ) #display dialog width of col as text    � � � � F d i s p l a y   d i a l o g   w i d t h   o f   c o l   a s   t e x t �  � � � l  � ��� � ���   � 1 +display dialog minimum width of col as text    � � � � V d i s p l a y   d i a l o g   m i n i m u m   w i d t h   o f   c o l   a s   t e x t �  � � � l  � ��� � ���   � 1 +display dialog maximum width of col as text    � � � � V d i s p l a y   d i a l o g   m a x i m u m   w i d t h   o f   c o l   a s   t e x t �  � � � l  � ���������  ��  ��   �  � � � I  � ��� ���
�� .sysodlogaskr        TEXT � b   � � � � � b   � � � � � b   � � � � � m   � � � � � � �  I n d i c e s :   � l  � � ����� � n   � � � � � 1   � ���
�� 
pidx � o   � ����� 0 name_col  ��  ��   � m   � � � � � � �  ,   � l  � � ����� � n   � � � � � 1   � ���
�� 
pidx � o   � ����� 0 mod_col  ��  ��  ��   �  � � � r   � � � � � n   � � � � � 1   � ���
�� 
pidx � o   � ����� 0 name_col   � o      ���� 0 temp   �  � � � r   � � � � � m   � �����  � n       � � � 1   � ���
�� 
pidx � o   � ����� 0 name_col   �  � � � r   � � � � o   � ����� 0 temp   � n       � � � 1  ��
�� 
pidx � o   ����� 0 mod_col   �  � � � l �� � ���   � Q Kdisplay dialog "Widths: " & (width of name_col) & ", " & (width of mod_col)    � � � � � d i s p l a y   d i a l o g   " W i d t h s :   "   &   ( w i d t h   o f   n a m e _ c o l )   &   " ,   "   &   ( w i d t h   o f   m o d _ c o l ) �  � � � l ��������  ��  ��   �  � � � l �� ��    [ Uset visible of first column of options whose name is modification date column to true    � � s e t   v i s i b l e   o f   f i r s t   c o l u m n   o f   o p t i o n s   w h o s e   n a m e   i s   m o d i f i c a t i o n   d a t e   c o l u m n   t o   t r u e �  l ����   X Rset visible of first column of options whose name is creation date column to false    � � s e t   v i s i b l e   o f   f i r s t   c o l u m n   o f   o p t i o n s   w h o s e   n a m e   i s   c r e a t i o n   d a t e   c o l u m n   t o   f a l s e 	 l ����~��  �  �~  	 

 l �}�}   0 *display dialog (width of name_col) as text    � T d i s p l a y   d i a l o g   ( w i d t h   o f   n a m e _ c o l )   a s   t e x t  l �|�|   ) #set width of name_col to name_col_w    � F s e t   w i d t h   o f   n a m e _ c o l   t o   n a m e _ c o l _ w  l �{�z�y�{  �z  �y    l �x�x   + % Change the target to force an update    � J   C h a n g e   t h e   t a r g e t   t o   f o r c e   a n   u p d a t e  r   c    1  �w
�w 
pins  m  �v
�v 
alis o      �u�u 0 currentfolder currentFolder !"! r   #$# I �t%�s
�t .earsffdralis        afdr% m  �r
�r afdrdocs�s  $ o      �q�q 0 otherfolder otherFolder" &'& r  !-()( o  !$�p�p 0 otherfolder otherFolder) n      *+* 1  (,�o
�o 
fvtg+ 4 $(�n,
�n 
cwin, m  &'�m�m ' -.- r  .:/0/ o  .1�l�l 0 currentfolder currentFolder0 n      121 1  59�k
�k 
fvtg2 4 15�j3
�j 
cwin3 m  34�i�i . 454 l ;;�h�g�f�h  �g  �f  5 676 l ;;�e89�e  8 = 7 Close and reopen the window so the change is reflected   9 �:: n   C l o s e   a n d   r e o p e n   t h e   w i n d o w   s o   t h e   c h a n g e   i s   r e f l e c t e d7 ;<; l ;;�d=>�d  = % set f to target of front window   > �?? > s e t   f   t o   t a r g e t   o f   f r o n t   w i n d o w< @A@ l ;;�cBC�c  B  close front window   C �DD $ c l o s e   f r o n t   w i n d o wA EFE l ;;�bGH�b  G  open f   H �II  o p e n   fF J�aJ l ;;�`�_�^�`  �_  �^  �a    m     KK�                                                                                  MACS  alis    t  Macintosh HD               զdH+     /
Finder.app                                                      ����~        ����  	                CoreServices    զG�      ��o�       /   .   -  6Macintosh HD:System: Library: CoreServices: Finder.app   
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��  ��  ��       �]LM�\�[�Z�Y�X�W�VNOPQR�U�T�S�]  L �R�Q�P�O�N�M�L�K�J�I�H�G�F�E�D�C
�R .aevtoappnull  �   � ****�Q 	0 win_w  �P 	0 win_h  �O 0 
name_col_w  �N 0 start_h  �M 0 start_v  �L 	0 end_h  �K 0 endv  �J 0 options  �I 0 name_col  �H 0 mod_col  �G 0 size_col  �F 0 kind_col  �E 0 temp  �D  �C  M �BS�A�@TU�?
�B .aevtoappnull  �   � ****S k    =VV  �>�>  �A  �@  T  U )K�=�<�;�:�9�8�7�6�5�4�3�2�1�0�/�.�-�,W�+�*�)�(�'�&�%�$�# ��" ��!� �������
�= .miscactvnull��� ��� obj �<��; 	0 win_w  �:��9 	0 win_h  �8,�7 0 
name_col_w  
�6 
cwin
�5 
pbnd
�4 
cobj�3 0 start_h  �2 0 start_v  �1 	0 end_h  �0 �/ 0 endv  
�. 
lvop�- 0 options  
�, 
lvclW  
�+ 
pnam
�* elsvelsn�) 0 name_col  
�( elsvelsm�' 0 mod_col  
�& elsvelss�% 0 size_col  
�$ elsvelsk�# 0 kind_col  
�" 
pidx
�! .sysodlogaskr        TEXT�  0 temp  
� 
pins
� 
alis� 0 currentfolder currentFolder
� afdrdocs
� .earsffdralis        afdr� 0 otherfolder otherFolder
� 
fvtg�?>�:*j O�E�O�E�O�E�O*�k/�,E[�k/E�Z[�l/E�Z[�m/E�Z[��/E�ZO�������v*�k/�,FO*�k/a ,E` O_ a k/a [a ,\Za 81E` O_ a k/a [a ,\Za 81E` O_ a k/a [a ,\Za 81E` O_ a k/a [a ,\Za 81E` Oa _ a ,%a %_ a ,%j  O_ a ,E` !Om_ a ,FO_ !_ a ,FO*a ",a #&E` $Oa %j &E` 'O_ '*�k/a (,FO_ $*�k/a (,FOPU�\��[��Z,�YD�XC�W,�V�N XX Y�Y K���
� 
brow�4}
� kfrmID  
� 
lvopO ZZ [���[ \�\ K���
� 
brow�4}
� kfrmID  
� 
lvop
� 
lvcl
� ****elsn
� kfrmID  P ]] ^���^ _�
_ K�	��
�	 
brow�4}
� kfrmID  
�
 
lvop
� 
lvcl
� ****elsm
� kfrmID  Q `` a���a b�b K��� 
� 
brow�4}
�  kfrmID  
� 
lvop
� 
lvcl
� ****elss
� kfrmID  R cc d������d e��e K������
�� 
brow��4}
�� kfrmID  
�� 
lvop
�� 
lvcl
�� ****elsk
�� kfrmID  �U �T  �S   ascr  ��ޭ