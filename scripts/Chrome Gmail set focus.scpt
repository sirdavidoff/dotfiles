FasdUAS 1.101.10   ��   ��    k             l     ����  r       	  m      
 
 �  J 
 
 f u n c t i o n   i s V i s i b l e ( e l )   { 
         r e t u r n   ( e l   ! = =   n u l l   & &   e l . o f f s e t P a r e n t   ! = =   n u l l ) 
 } 
 
 f u n c t i o n   f i r e ( e l e m ,   e v e n t N a m e )   { 
 	 e l e m . d i s p a t c h E v e n t ( n e w   M o u s e E v e n t ( e v e n t N a m e ,   { 
         	 ' v i e w ' :   w i n d o w , 
         	 ' b u b b l e s ' :   t r u e , 
         	 ' c a n c e l a b l e ' :   t r u e , 
         	 ' s c r e e n X ' :   e l e m . l e f t , 
         	 ' s c r e e n Y ' :   e l e m . t o p 
 	 } ) ) ; 
 } 
 
 
 f u n c t i o n   h i d e V i s i b l e M e n u s ( )   { 
 	 / /   J u s t   c l i c k   s o m e w h e r e   t h a t   w i l l   c h a n g e   t h e   f o c u s   b u t   w o n ' t   d o   a n y t h i n g   e l s e 
 	 v a r   h e a d e r   =   d o c u m e n t . q u e r y S e l e c t o r ( " h e a d e r [ r o l e = ' b a n n e r ' ] " ) ; 
 	 f i r e ( h e a d e r ,   ' m o u s e d o w n ' ) ; 
 	 
 	 / * f o r   ( v a r   i = 0 ;   i < m e n u s . l e n g t h ; i + + ) { 
 	 	 i f ( i s V i s i b l e ( m e n u s [ i ] ) )   { 
 	 	 	 v a r   s t y l e   =   m e n u s [ i ] . g e t A t t r i b u t e ( ' s t y l e ' ) ; 
 	 	 	 m e n u s [ i ] . s e t A t t r i b u t e ( ' s t y l e ' ,   s t y l e   +   '   d i s p l a y :   n o n e ; ' ) ; 
 	 	 } 
 	 } * / 
 } 
 
 / /   R e t u r n s   t h e   f i r s t   e x p a n d e d ,   v i s i b l e   c o m p o s e   p a n e 
 f u n c t i o n   g e t C o m p o s e W i n ( )   { 
 	 / /   N B :   T h i s   i s   l i k e l y   t o   b r e a k   i n   t h e   f u t u r e   i f   t h e   c l a s s e s   c h a n g e ! ! ! 
 	 v a r   w i n s   =   d o c u m e n t . q u e r y S e l e c t o r A l l ( " d i v [ c l a s s * = ' i n b o x s d k _ _ c o m p o s e   i n b o x s d k _ _ s i z e _ f i x e r ' ] " ) 
 	 f o r   ( v a r   i = 0 ;   i < w i n s . l e n g t h ; i + + ) { 
 	 	 i f ( i s V i s i b l e ( w i n s [ i ] . c h i l d r e n [ 2 ] ) )   r e t u r n   w i n s [ i ] 
 	 } 
 } 
 
 
 / /   R e t u r n s   t h e   f i r s t   e x p a n d e d ,   v i s i b l e   c o m p o s e   i n l i n e   e l e m e n t 
 f u n c t i o n   g e t C o m p o s e I n l i n e ( )   { 
 	 / /   N B :   T h i s   i s   l i k e l y   t o   b r e a k   i n   t h e   f u t u r e   i f   t h e   c l a s s e s   c h a n g e ! ! ! 
 	 v a r   w i n s   =   d o c u m e n t . q u e r y S e l e c t o r A l l ( " d i v [ c l a s s * = ' i n b o x s d k _ _ c o m p o s e _ i n l i n e R e p l y ' ] " ) 
 	 f o r   ( v a r   i = 0 ;   i < w i n s . l e n g t h ; i + + ) { 
 	 	 i f ( i s V i s i b l e ( w i n s [ i ] . c h i l d r e n [ 2 ] ) )   r e t u r n   w i n s [ i ] 
 	 } 
 } 
 
 / /   I f   w e ' r e   i n   a   v i e w   l i k e   t h e   i n b o x   w i t h   m u l t i p l e   t h r e a d s   i n   r o w s , 
 / /   R e t u r n   t h e   f i r s t   r o w   o f   t h e   t a b l e 
 f u n c t i o n   g e t F i r s t T h r e a d R o w ( )   { 
 	 v a r   m a i n   =   d o c u m e n t . q u e r y S e l e c t o r ( " d i v [ r o l e = ' m a i n ' ] " ) ; 
 	 v a r   r o w s   =   m a i n . q u e r y S e l e c t o r A l l ( ' t r ' ) 
 	 f o r   ( v a r   i = 0 ;   i < r o w s . l e n g t h ; i + + ) { 
 	 	 i f ( i s V i s i b l e ( r o w s [ i ] ) )   r e t u r n   r o w s [ i ] 
 	 } 
 } 
 
 f u n c t i o n   c l i c k C o m p o s e W i n T o ( c o m p o s e W i n ) { 
 
 	 v a r   f o r m   =   c o m p o s e W i n . q u e r y S e l e c t o r ( ' f o r m ' ) ; 
 	 i f ( ! i s V i s i b l e ( f o r m . c h i l d r e n [ 0 ] ) ) { 
 	 	 / /   T h e   ' t o '   f i e l d   h a s n ' t   b e e n   e x p a n d e d   y e t 
 	 	 f o r m . c h i l d r e n [ 1 ] . s e t A t t r i b u t e ( ' s t y l e ' ,   ' d i s p l a y :   n o n e ' ) 
 	 	 f o r m . c h i l d r e n [ 0 ] . s e t A t t r i b u t e ( ' s t y l e ' ,   ' ' ) 
 	 } 
 	 
 	 v a r   t o F i e l d   =   f o r m . q u e r y S e l e c t o r ( ' t e x t a r e a [ a r i a - l a b e l = " T o " ] ' ) ; 
 	 t o F i e l d . f o c u s ( ) ; 
 } 
 
 / /   H i d e   a n y   m e n u s   t h a t   a r e   s h o w i n g 
 h i d e V i s i b l e M e n u s ( ) ; 
 
 s e t T i m e o u t ( f u n c t i o n ( ) { 
 
 	 / /   G e t   t h e   e l e m e n t s   w e   m i g h t   w a n t   t o   f o c u s   o n 
 	 v a r   v a l i d C o m p o s e W i n   =   g e t C o m p o s e W i n ( ) ; 
 	 v a r   v a l i d C o m p o s e I n l i n e   =   g e t C o m p o s e I n l i n e ( ) ; 
 	 v a r   f i r s t T h r e a d R o w   =   g e t F i r s t T h r e a d R o w ( ) ; 
 
 	 i f ( v a l i d C o m p o s e W i n   ! =   n u l l )   { 
 	 	 / /   I f   w e ' r e   i n   a   m o d a l   c o m p o s e   w i n d o w ,   f o c u s   o n   t h e   ' T o '   f i e l d 
 	 	 / / a l e r t ( ' V a l i d   c o m p o s e   w i n ' ) 
 	 	 c l i c k C o m p o s e W i n T o ( v a l i d C o m p o s e W i n ) ; 
 	 	 
 	 }   e l s e   i f ( v a l i d C o m p o s e I n l i n e   ! =   n u l l )   { 
 	 	 / /   I f   w e ' r e   i n   a n   i n l i n e   c o m p o s e   w i n d o w ,   f o c u s   o n   t h e   m e s s a g e   b o d y 
 	 	 / / a l e r t ( ' I n l i n e   c o m p o s e ' ) ; 
 	 	 v a r   e   =   v a l i d C o m p o s e I n l i n e . q u e r y S e l e c t o r ( ' d i v [ a r i a - l a b e l = " M e s s a g e   B o d y " ] ' ) ; 
 	 	 e . f o c u s ( ) ; 
 	 	 
 	 }   e l s e   i f ( f i r s t T h r e a d R o w   ! =   n u l l ) { 
 	 	 / /   I f   w e ' r e   i n   a n   i n b o x - l i k e   v i e w ,   f o c u s   o n   t h e   f i r s t   t h r e a d   r o w 
 	 	 / / a l e r t ( ' R o w ' ) 
 	 	 f i r s t T h r e a d R o w . f o c u s ( ) ; 
 	 } 
 
 } , 
 2 0 0 ) ; 
 
 	 o      ���� 0 code  ��  ��        l     ��������  ��  ��     ��  l    ����  O        O       r        I   ���� 
�� .CrSuExJanull���     obj ��    �� ��
�� 
JvSc  o    ���� 0 code  ��    1      ��
�� 
rslt  n       1    ��
�� 
acTa  4   �� 
�� 
cwin  m   
 ����   m      �                                                                                  rimZ  alis    >  Macintosh HD                   BD ����Google Chrome.app                                              ����            ����  
 cu             Applications  !/:Applications:Google Chrome.app/   $  G o o g l e   C h r o m e . a p p    M a c i n t o s h   H D  Applications/Google Chrome.app  / ��  ��  ��  ��       ��   
��    ����
�� .aevtoappnull  �   � ****�� 0 code    �� ����   ��
�� .aevtoappnull  �   � ****  k      ! !   " "  ����  ��  ��         
�� ������������ 0 code  
�� 
cwin
�� 
acTa
�� 
JvSc
�� .CrSuExJanull���     obj 
�� 
rslt�� �E�O� *�k/�, *��l E�UU ascr  ��ޭ