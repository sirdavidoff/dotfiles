FasdUAS 1.101.10   ��   ��    k             l     ����  r       	  m      
 
 �  � 
 
 f u n c t i o n   i s V i s i b l e ( e l )   { 
         r e t u r n   ( e l   ! = =   n u l l   & &   e l . o f f s e t P a r e n t   ! = =   n u l l ) 
 } 
 
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
 / /   R e t u r n s   t h e   f i r s t   e x p a n d e d ,   v i s i b l e   c o m p o s e   p a n e 
 f u n c t i o n   g e t C o m p o s e W i n ( )   { 
 	 / /   N B :   T h i s   i s   l i k e l y   t o   b r e a k   i n   t h e   f u t u r e   i f   t h e   c l a s s e s   c h a n g e ! ! ! 
 	 v a r   w i n s   =   d o c u m e n t . q u e r y S e l e c t o r A l l ( " d i v [ c l a s s * = ' i n b o x s d k _ _ c o m p o s e   i n b o x s d k _ _ s i z e _ f i x e r ' ] " ) 
 	 f o r   ( v a r   i = 0 ;   i < w i n s . l e n g t h ; i + + ) { 
 	 	 i f ( i s V i s i b l e ( w i n s [ i ] . c h i l d r e n [ 2 ] ) )   r e t u r n   w i n s [ i ] 
 	 } 
 } 
 
 / /   R e t u r n s   t h e   ' L a b e l s '   b u t t o n   o n   t h e   t o p   t o o l b a r ,   i f   i t ' s   v i s i b l e 
 f u n c t i o n   g e t T o o l b a r L a b e l B u t t o n ( )   { 
 	 v a r   b u t t o n s   =   d o c u m e n t . q u e r y S e l e c t o r A l l ( ' [ a r i a - l a b e l = " L a b e l s " ] , [ t i t l e = " L a b e l s " ] ' ) ; 
 	 f o r   ( v a r   i = 0 ;   i < b u t t o n s . l e n g t h ; i + + ) { 
 	 	 i f ( i s V i s i b l e ( b u t t o n s [ i ] ) )   r e t u r n   b u t t o n s [ i ] 
 	 } 
 } 
 
 / /   R e t u r n s   t h e   ' L a b e l s '   m e n u   i t e m   i n   t h e   f i r s t   f l o a t i n g   m e n u   f o u n d 
 f u n c t i o n   g e t L a b e l M e n u I t e m ( )   { 
         v a r   m e n u s   =   d o c u m e n t . q u e r y S e l e c t o r A l l ( ' d i v [ r o l e = " m e n u i t e m " ] ' ) 
         v a r   x   =   [ ] ;   
         f o r   ( v a r   i = 0 ;   i < m e n u s . l e n g t h ; i + + ) {   
                 i f ( i s V i s i b l e ( m e n u s [ i ] )   & &   m e n u s [ i ] . i n n e r H T M L . i n c l u d e s ( ' L a b e l < ' ) )   { 
                         x . p u s h ( m e n u s [ i ] ) ;   
                 } 
         } 
         r e t u r n   x [ 0 ] 
 } 
 
 / /   R e t u r n s   t h e   i n p u t   b o x   i n   t h e   l a b e l s   m e n u   ( i . e   t h e   t h i n g   y o u   u s e 
 / /   t o   s e a r c h   f o r   l a b e l s ) 
 f u n c t i o n   g e t L a b e l S e a r c h B o x ( )   { 
 	 v a r   i n p u t s   =   d o c u m e n t . q u e r y S e l e c t o r A l l ( ' i n p u t [ c l a s s = " b q f " ] ' ) ; 
 	 v a r   x   =   [ ] ;   
         f o r   ( v a r   i = 0 ;   i < i n p u t s . l e n g t h ; i + + ) {   
                 i f ( i s V i s i b l e ( i n p u t s [ i ] ) )   { 
                         x . p u s h ( i n p u t s [ i ] ) ;   
                 } 
         } 
 	 r e t u r n   x [ 0 ] 
 } 
 
 / /   W o r k   o u t   i f   w e   w a n t   t o   g e t   t o   t h e   l a b e l   m e n u   v i a   t h e   t o o l b a r   a t   t h e   t o p 
 / /   o r   t h e   ' M o r e   i n f o '   m e n u   a t   t h e   b o t t o m   o f   a   c o m p o s e   p a n e   ( t h e   l a t t e r   t a k e s 
 / /   p r e c e d e n c e 
 v a r   v a l i d C o m p o s e W i n   =   g e t C o m p o s e W i n ( ) ; 
 i f ( v a l i d C o m p o s e W i n   ! =   n u l l )   { 
 	 v a r   b u t t o n   =   v a l i d C o m p o s e W i n . q u e r y S e l e c t o r ( " d i v [ a r i a - l a b e l = ' M o r e   o p t i o n s ' ] " ) ; 
 	 / / a l e r t ( ' v a l i d   c o m p o s e ' ) 
 }   e l s e   { 
 	 v a r   b u t t o n   =   g e t T o o l b a r L a b e l B u t t o n ( ) ; 
 } 
 
 / /   C l i c k   o n   t h e   m e n u 
 i f ( b u t t o n   ! =   n u l l )   { 
 	 f i r e ( b u t t o n ,   ' m o u s e d o w n ' ) ; 
 } 
 
 s e t T i m e o u t ( f u n c t i o n ( ) { 
 	 
 	 / /   I f   w e   n e e d   t o   g o   t o   a   s u b m e n u ,   m o u s e   o v e r   t h e   a p p r o p r i a t e 
 	 / /   m e n u   i t e m 
 	 v a r   l a b e l M e n u I t e m   =   g e t L a b e l M e n u I t e m ( ) ; 
 	 
 	 i f ( l a b e l M e n u I t e m )   { 
 	 	 f i r e ( l a b e l M e n u I t e m ,   ' m o u s e o v e r ' ) ; 
 	 } 
 	 
 	 / * s e t T i m e o u t ( f u n c t i o n ( ) { 
 	 	 
 	 	 / /   C l i c k   o n   t h e   l a b e l   i n p u t   b o x   s o   t h a t   w e   c a n   s t a r t   t y p i n g 
 	 	 / /   s t r a i g h t   a w a y 
 	 	 / / a l e r t ( ' H e r e ' ) 
 	 	 / / v a r   l a b e l I n p u t   =   g e t L a b e l S e a r c h B o x ( ) ; 
 	 	 i f ( l a b e l I n p u t )   { 
 	 	 	 f i r e ( l a b e l I n p u t ,   ' m o u s e d o w n ' ) 
 	 	 } 
 	 } , 
 	 1 0 0 0 
 	 ) ; * / 
 	 
 	 } , 
 	 1 0 0 
 ) ; 
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