PGDMP         4                {         
   BookMarket    15.2    15.2 8    ;           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            <           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            =           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            >           1262    41934 
   BookMarket    DATABASE     �   CREATE DATABASE "BookMarket" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE "BookMarket";
                postgres    false            �            1259    41936    carts    TABLE     L   CREATE TABLE public.carts (
    id integer NOT NULL,
    user_id integer
);
    DROP TABLE public.carts;
       public         heap    postgres    false            �            1259    41935    carts_id_seq    SEQUENCE     �   CREATE SEQUENCE public.carts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.carts_id_seq;
       public          postgres    false    215            ?           0    0    carts_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.carts_id_seq OWNED BY public.carts.id;
          public          postgres    false    214            �            1259    41942    carts_products    TABLE     g   CREATE TABLE public.carts_products (
    cart_id integer NOT NULL,
    products_id integer NOT NULL
);
 "   DROP TABLE public.carts_products;
       public         heap    postgres    false            �            1259    41946    category    TABLE     [   CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(255)
);
    DROP TABLE public.category;
       public         heap    postgres    false            �            1259    41945    category_id_seq    SEQUENCE     �   CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.category_id_seq;
       public          postgres    false    218            @           0    0    category_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;
          public          postgres    false    217            �            1259    41953    image    TABLE     y   CREATE TABLE public.image (
    id integer NOT NULL,
    path character varying(255),
    product_id integer NOT NULL
);
    DROP TABLE public.image;
       public         heap    postgres    false            �            1259    41952    image_id_seq    SEQUENCE     �   CREATE SEQUENCE public.image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.image_id_seq;
       public          postgres    false    220            A           0    0    image_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.image_id_seq OWNED BY public.image.id;
          public          postgres    false    219            �            1259    41960    orders    TABLE        CREATE TABLE public.orders (
    id integer NOT NULL,
    count integer NOT NULL,
    date_time timestamp(6) without time zone,
    number character varying(255),
    price real NOT NULL,
    status character varying(255),
    product_id integer NOT NULL,
    user_id integer NOT NULL
);
    DROP TABLE public.orders;
       public         heap    postgres    false            �            1259    41959    orders_id_seq    SEQUENCE     �   CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.orders_id_seq;
       public          postgres    false    222            B           0    0    orders_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;
          public          postgres    false    221            �            1259    41969    product    TABLE     �  CREATE TABLE public.product (
    id integer NOT NULL,
    add_date timestamp(6) without time zone,
    description text NOT NULL,
    price real NOT NULL,
    title text NOT NULL,
    category_id integer NOT NULL,
    publishing character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    CONSTRAINT product_price_check CHECK ((price >= (1)::double precision))
);
    DROP TABLE public.product;
       public         heap    postgres    false            �            1259    41968    product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.product_id_seq;
       public          postgres    false    224            C           0    0    product_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;
          public          postgres    false    223            �            1259    41979    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    password character varying(255),
    role character varying(255),
    username character varying(50)
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    41978    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    226            D           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    225            �           2604    41939    carts id    DEFAULT     d   ALTER TABLE ONLY public.carts ALTER COLUMN id SET DEFAULT nextval('public.carts_id_seq'::regclass);
 7   ALTER TABLE public.carts ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            �           2604    41949    category id    DEFAULT     j   ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);
 :   ALTER TABLE public.category ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    218    218            �           2604    41956    image id    DEFAULT     d   ALTER TABLE ONLY public.image ALTER COLUMN id SET DEFAULT nextval('public.image_id_seq'::regclass);
 7   ALTER TABLE public.image ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    220    220            �           2604    41963 	   orders id    DEFAULT     f   ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);
 8   ALTER TABLE public.orders ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    222    222            �           2604    41972 
   product id    DEFAULT     h   ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);
 9   ALTER TABLE public.product ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223    224            �           2604    41982    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    226    226            -          0    41936    carts 
   TABLE DATA                 public          postgres    false    215   �;       .          0    41942    carts_products 
   TABLE DATA                 public          postgres    false    216   Z<       0          0    41946    category 
   TABLE DATA                 public          postgres    false    218   �<       2          0    41953    image 
   TABLE DATA                 public          postgres    false    220   O=       4          0    41960    orders 
   TABLE DATA                 public          postgres    false    222   *B       6          0    41969    product 
   TABLE DATA                 public          postgres    false    224   �C       8          0    41979    users 
   TABLE DATA                 public          postgres    false    226   �^       E           0    0    carts_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.carts_id_seq', 3, true);
          public          postgres    false    214            F           0    0    category_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.category_id_seq', 3, true);
          public          postgres    false    217            G           0    0    image_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.image_id_seq', 41, true);
          public          postgres    false    219            H           0    0    orders_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.orders_id_seq', 7, true);
          public          postgres    false    221            I           0    0    product_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.product_id_seq', 20, true);
          public          postgres    false    223            J           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 4, true);
          public          postgres    false    225            �           2606    41941    carts carts_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.carts DROP CONSTRAINT carts_pkey;
       public            postgres    false    215            �           2606    41951    category category_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    218            �           2606    41958    image image_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.image DROP CONSTRAINT image_pkey;
       public            postgres    false    220            �           2606    41967    orders orders_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public            postgres    false    222            �           2606    41977    product product_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public            postgres    false    224            �           2606    41988 $   product uk_qka6vxqdy1dprtqnx9trdd47c 
   CONSTRAINT     `   ALTER TABLE ONLY public.product
    ADD CONSTRAINT uk_qka6vxqdy1dprtqnx9trdd47c UNIQUE (title);
 N   ALTER TABLE ONLY public.product DROP CONSTRAINT uk_qka6vxqdy1dprtqnx9trdd47c;
       public            postgres    false    224            �           2606    41986    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    226            �           2606    42019 #   product fk1mtsbur82frn64de7balymq9s    FK CONSTRAINT     �   ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk1mtsbur82frn64de7balymq9s FOREIGN KEY (category_id) REFERENCES public.category(id);
 M   ALTER TABLE ONLY public.product DROP CONSTRAINT fk1mtsbur82frn64de7balymq9s;
       public          postgres    false    224    218    3212            �           2606    42014 "   orders fk32ql8ubntj5uh44ph9659tiih    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk32ql8ubntj5uh44ph9659tiih FOREIGN KEY (user_id) REFERENCES public.users(id);
 L   ALTER TABLE ONLY public.orders DROP CONSTRAINT fk32ql8ubntj5uh44ph9659tiih;
       public          postgres    false    222    226    3222            �           2606    41999 *   carts_products fk3nvguygrfbn661omvvu2uafu5    FK CONSTRAINT     �   ALTER TABLE ONLY public.carts_products
    ADD CONSTRAINT fk3nvguygrfbn661omvvu2uafu5 FOREIGN KEY (cart_id) REFERENCES public.carts(id);
 T   ALTER TABLE ONLY public.carts_products DROP CONSTRAINT fk3nvguygrfbn661omvvu2uafu5;
       public          postgres    false    3210    215    216            �           2606    42009 "   orders fk787ibr3guwp6xobrpbofnv7le    FK CONSTRAINT     �   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk787ibr3guwp6xobrpbofnv7le FOREIGN KEY (product_id) REFERENCES public.product(id);
 L   ALTER TABLE ONLY public.orders DROP CONSTRAINT fk787ibr3guwp6xobrpbofnv7le;
       public          postgres    false    224    222    3218            �           2606    41989 !   carts fkb5o626f86h46m4s7ms6ginnop    FK CONSTRAINT     �   ALTER TABLE ONLY public.carts
    ADD CONSTRAINT fkb5o626f86h46m4s7ms6ginnop FOREIGN KEY (user_id) REFERENCES public.users(id);
 K   ALTER TABLE ONLY public.carts DROP CONSTRAINT fkb5o626f86h46m4s7ms6ginnop;
       public          postgres    false    215    226    3222            �           2606    42004 !   image fkgpextbyee3uk9u6o2381m7ft1    FK CONSTRAINT     �   ALTER TABLE ONLY public.image
    ADD CONSTRAINT fkgpextbyee3uk9u6o2381m7ft1 FOREIGN KEY (product_id) REFERENCES public.product(id);
 K   ALTER TABLE ONLY public.image DROP CONSTRAINT fkgpextbyee3uk9u6o2381m7ft1;
       public          postgres    false    3218    220    224            �           2606    41994 *   carts_products fkk7xfh233qlp4sxsfou7mdvi3t    FK CONSTRAINT     �   ALTER TABLE ONLY public.carts_products
    ADD CONSTRAINT fkk7xfh233qlp4sxsfou7mdvi3t FOREIGN KEY (products_id) REFERENCES public.product(id);
 T   ALTER TABLE ONLY public.carts_products DROP CONSTRAINT fkk7xfh233qlp4sxsfou7mdvi3t;
       public          postgres    false    216    3218    224            -   O   x���v
Q���W((M��L�KN,*)V��L�Q(-N-��L�Ts�	uV�0�Q0Ҵ��$M����!麌u����� �(/�      .   H   x���v
Q���W((M��L�KN,*)�/(�O)M.)V� ��3St`B@��B��O�k��������5 ���      0   �   x���v
Q���W((M��L�KN,IM�/�T��L�Q�K�M�Ts�	uV�0�QP�0�b�[/컰�7����\��e2jʅ��.l��H�b7��Ծ��^�q��@g� �z���M�A4�\.. trb�      2   �  x���A��5���{���U�8�#Nz��@���r��ZU-|}^�2�;Yi���Vo�ؿ����7�~����?����K���x|�������ˇ���7�������o����_����Wo�Ǘ�X*�Z��E�h�L�R�Y��sz���?����C|�����S,AL�i��4�#�G'uU��M��%5>�'�����̔E��E�M�JXV
k�|�,�e��*SR�t*ɌLj�h�d3Xm5�{e'bbZF��'�Y!� ]�C�眤�+�����X�Iӑ�u����-��+;S�EO�V�j�$�3�ɠ�ڦ�)�1=�X��j5M͑ڬ������^��y���֣|�b��Z4�BcMto�E-�JiΔb�1�y�r��{#�diT�w�Bm�Fa���uI����m�� l�F�E�e�5c��K�T��v��)2Bs�ވ�a�M�l�I�ޅC����������ۿ����W�z�����hJ�Ɏ����*~Bxܚ�j����ӊo�w�bF��$�к�F%cc��Z���j
��Vu�@#�7���Z�8��x�TO�6u��E-O*61Q��3'���V42@q��#���"keMB`L�s��y&Ә,�R�z��#�͝m%��_�P�p[m�Ƀ-��W����v�7w,��
%wt2cxz�J<����|9ӑ߬)�V��L1�4XFw�EY���N�ݸ�T��:H �'[,@lm�Cֽ�N�6x8s_�%t�s�`�$���� t�<�ۤII.4(p ×e8�Z�kґk�6��<��l��G*�������Z�#H]9��k��O�6O<�	!�Y�,��2-��j�4(�\��m� xZoRh�@��\��	��% �s���Gr7��
1"w�1�u�{f!�|o梥��̓�7R|`?i�����(6�o�涮f��͔4�0��r"��"�Z�6�]1�L�o���dJQ�^DЕa&�d2����'�:ś�{��'��v����Έ�+����|�O"��R��` )O��q��4�.s\MWu'�7m�h.��Tr�d��g��R\6Ě(�UݑܦJe_�!.x)b�F�w_đ<��L�Q9�+�k%WN�V���(�L�F�4����M{5�$ԧM�5{�ܰi�p�Q��X�Y0)� ���#9��z��qe��R�a�[Y4��5�u5�H��"�HX��5����������{��Wu'�^6U���0*�% ���Ô�ch=T,B���rϞ��$�N      4   �  x��ӽn�0 ���B�%�e��DI��!�E
4i�@hr���;�9�����UN�\d�&���v�W�����������}jC.�Q��s#�a���Xn��mi��t�Ј�a�jx�8��4�,��c��\|y���ŕ8�F`#��$hIF w �Q-+ �5k]��J��"5;��'R�A�ZG���������÷���k�9���zM��6�5@�%���O�V�"rd�[DN�܊ }
�]�EK�,�n��I@j��hi{tH���{fD��2�@Fu�u�S�TJ�d�,Qy��q�YF�A0:ݧ�o��V�a����c<K�9WP
2*�+�}a]M��V[9�D����m����YŢ��L�����B����0�>�y�*h��,�H      6      x��\ݎ\Օ�G�;���D*������$�#�Q�"c{���1�\���mǍۀ�xl���TW��:�wZ�	N�/0�0k}�Z{�S�v����(�:u�>{��~�������/�g������?|�������l\������مK�~{���ˍ���.^Y����{���+�������ʟ�r�[W���F�����ޒ�?���ƕ_fo���_~-��R#{qana������l~ym����|sei������d��*��<���#�o��0�q�n6�h�]�Y5�kEթZYխ���L.�݆|�ړ[2B1٬Z�Ŷ99hf���Ve5�K�4��峾c$����>���ÖU���m� ���rM��{ɘ��y$ON�;ٛ��������%^�C'/��s�U�.���n����߲���<�ˑ����ö䎮�^�7ٞ����ۙ̄#��}�pK���J
NĢ���v��=��#f֝lʀz����~����;�Q3��ߝ�.C&�W=y^&±3H`(��Xq�{&7�Ĭ�2T�c~��#��-�M݇�?�W��MߥFx}��٥J�����Ɏ�7�R��t�:W�"D�E���w7��Hv(�Wa�m���Og�����!�4}���ΈJ�2��mYD)�ߒIQ�J���[�Uwf��ubYP��.l��(�]��,��P�����x�~4�Оm�m�6v=�E��ӂ;��"�m�j��v(n5��X>CS�8OqX>dx�@t.̭%���@�u��uU��M�Q��>-fSwl�Ӳ��ې������*��oP�wTj �D=[66Eq Ê���6�]MZF�i(��P��;��1����*����Ju�dSk�o]X�{�T�{|�q��������Y���W��8'�u���/��Lc��lYY[^i.���_?�	n�T��j�ڧ�(�g��>6T�Зm+&�؜G՟�;T��~��G��@��r�0�(�&n��.��i���T-����2�_�?�P[3����)lᙑjܞj��g]RO�h��GD�`l�A���^YpzC�N���a�c���*��#2�w+�J�<�B��$��<;%�u���:�p6���x��`�HU��<v�_�z9�]>�A� ��&�����O�j��0ئL��g�u #�/��\݈�:�����/�`��J���ގ������[ݙY�[][>�\Y�_57ѥ�U�R��F�ԻSv�K塺��pjW�Qo��{;UݟR��};\�)�7j+>L/��� j�=�:ݎ�&���_�`9� ���F��6�}D��r�k�ů�'�G��g�JPZ����ub�0�#��0�Vj�0��ڂ�1���y_a�SQ{���6��\V�s4��L0TB��9p ��6�]�\�
���c��Jt*���q��k�j ��,\�؅�`�>t��,��"�1�#W�t���.�(���M�T}�b�>���)�n�d����ԖW�,����h�Ǎ��卋�^������)3��4���������rsey���l���tE��� ��g�Dww`�:�x�~ �fU_q�g�	����}v;`�#6���B����mN�����3����3�#"�g`����`!��|�{��@j��� _��ȼ�6���I�^P��F%�-w�g�Z� ���U���zS�P���\�k��AC�|��W95V��骦�#���.UP�hUƿ��r�b�� ���/:�W�`��]z �҅l�G�={Ŗ�~�ׯ����$3�Q��b8�O��1UW�f�&2�5��8"#�>�.`~A�k#Y�%Q�������z8{5�~i�+�1R�������sc���Ȱ�n��.2�}ޅ�5d����4�'Vtພ
�����Hu���
-A���a{s"N�y1l�
�k��6fz+u|�AG��>���rͶ���G���Ô�{:mF��2�����B3�@MـP���;�	�̋����j�W�F�ir�{n�b2�H�W�����E����Ղ��&&�,��vu��A�Sϩ�x��`���:2V�z��Z����־�:���O �tO����3�5����L��7�ǃ��"�-��OC�[n�5~�~g1��NX�֫��b�߆�'#d��-c[��5A6xi۲>�ß#��x��2[5�PC�q��P�{%#)SFn�JXԡ��^�)���v��mD�P<ǌR�����.0kc�t�K�x��SQ�v&'�,<�%�c�b� gY���s�����U�>F����䆥��pVc�<��n�RE��i�wtHۍ�vU&08�~ ��n�n�92E����d1_(����=�6�>��wuJ�cM�}���7�X?��`,}�"���a �x��1T��d��G1��yT�t9��04���U�~7"Hp�����F���,1q
B�u�DАh�0��V�*_�s�a��LaFUF^�b�
c< ��'\��yw	�{D`�@�Է�Ĺ��3��#�8oU�;��N2�1k9�e�fVcD2q*���qe��g�7p�6��$u��n)Sҏ1�V1�g'���
B`:t�E����trl�*����I3U�Ѣ��!���v���*��'�\�ѳ������Bsan�������"�����՟���v,�E�^T�d5�O�BǨ�cl0�?��^����Y����1ga����+Y�cczI�C2RM� �'�| )ڳ9�"kXki�t����̱�U�bWk����!�4����)R�ܗa�#s:�@�0�`�PxEo��h,Dż���AXL�bӏ���9�c��<IN��R1��m����I���u�[�k����Om�������Z���$�P�d 9�o>p��^u���#ƞFt�MfNp�i0��9աuDyѷ)J�]T^������M��D%�̰���"y`�{�*BA����v�0
utGƽ�q�9�2��Ġ)�aD�%f	ge�y�ܴX{�#+Ŷ���Y����
T�e��n'�Q���k���m��<��|rK�G�ɰ浽���+?}�M��#�ѝ�Y9�h&�k�8��eSdԏ�:a�{P@C�2#�t|%t~O�3�j�X��Q�
[b5�XEG���X���G #�\�=9�-�hk�`�B�zmXP�V��r�(��]J��Ѷ'H�����a

���Rt����;��c��H�W���L	��[� c�!x0c3�^R̷������xf�γ�髳1����B�����_Ȯ��ߧ��Y�3pQ�����0��M�O�g�V	����v���:)]V�h����W/��q�ʥ쵫Wt��?����H�-΅j���%�p��H(�f�fo!��+42iIhf��� �G��I��q��i��꺎��b�:���+o^hdol\��o�]�ɼ�~�����|i�W�X�?H��/>�n÷�{��\�D�xX����}�K�z����_|���r��ߩ����5�����>���&�^����1����}#��`�Ot-�|)s�:�>���w����1�·��?���Qq����sW�x�|�/x�=�?����;X�|Ƥ>�ޒD����3�|ܚ>{�QN�}�T�eN��/,YE�'��Ŋo��11n�s��!��a����RDyR�Q_}ǰZFף2~Ь@_ᦶMn�o�ѐ�����`3�RZ�!,3,2��l����9�Q�0�+S�Y��( 1U��N0����g+mYz�ȎUl(#���p��ad�D'+?i�2���]���p�-�˛��LYO�WO�do�y���������|XFN ���hSDae��koT�� �&���g��U��S}lfN&{��_!]eh;��N�f�O(�9��ES��(�,�����S�}�����+k�K͕关g^�- �9�u��]�#�k1t���i�۶� �tm!qa�r�B���,�
��|E���� �0 �7�|�1�#�b�KLB�3�7!g�\�:Ϙ�;7]�`���2{���$�VȨ/��;���Zf}HD����vR��#.����"m-�[Lj��� �
  B�E�!�zJ��?�]}��Ƈ�d#,O��\
�u�б�v��NF��t�A:��T�gM��ڒ����������:�#�ٶ~�.1V�)C=���=�U@�����3.6X1E[͙IH�]'Z�v�� t�[ͽq,���ĘAwl� �$��o��~�=U�H�!ʷ�TN��f4SE��^�T�|�>���MT�6;�ؠ]vh%:�u�3���yJL��1qIfo�]j�jX������Ɍ��T�V��hgh��qi(y2��AY��<vl=:6�hv/|qV�Sw:�h��Bl�q�ؑȭ��&�"�&h�(�˟с��DD�$I7L�FT�Z:e�t,�8q�9��
��!�k=)��1ow3e��z�t��e��M����Uy�pD"Qj+��ڬENk�0�1ٮy�[ͺsࠗ�صt���I�@'%��EIĀeQg)f���l>�|KJ�k�]Wy(��<�&�?Z���kK��平Kg1߯�vo�0$�~~���^����Sl�1F(i������g4j���"��Ƅ*�ts��p��^���Ѷ櫽j��M�J='�nu�������7D�ͫ�5���#�L�25��iZl� U�BY��.s�k4K�iL���B�`;�$� �n��&��:5r��i2&Z��G�TLќ�Sbd�-�Y��v_�z�wXSKm\��R�*����VUQ��j˛�j=#�Ճ� 0��*�۳`�)�iE6/��"�25����������]LU�Q!�����8��H��gU��O�Vr��n}��xB��5B� :�����ұ�l�����c�Š�Q��YP.]���S��'��
G]+�@�{�����y�����ێo, -�I>Bor[�d��⬃\Z[\lέ��/zw����E���À�qmۏ�����ݦckL�e�<4��B�"���3B-;(卼�k3����
��x�1�I_S+���ڮ�*x����'�<���gټ�׿g�ٸ�N����.���B��~w�?7޳��=���e2�++�L� ��K��=�oZ�t����;��a���V@��\�����f����B:�W~�}�.-2Azw�\�ɭ�[�T�����1ܡU��$��b�C�n�	f1��k]�M%2��Dfe5��*�����fC�wT��,xz7�"��Z�Jxn�/y@�gD ʤ�������g�����#;~;����O��4H.�(���t����Q������W(t2H��,iְ7�*���,�����ɸ���sQ�����ֵ�`�*[>�-#T��tL<�Uhn��K2��;��Ķ��N:l)cy�	�1�N%�k�͂��C&-��moy�����{<��q�
�����u�1S��o�s(Ҷf�;��S�k�H$}y�Yy��#Ј�+;G�<�g���&�5�M�b���c�/v�����1��	-�%���{Sd>�(1?EZ��X�w�����LM��p\�S��[�瑞�U��ZB!�%zE ��w͔�ƿ��@�M-rUX�5O�&��~�|@;O�2^o63+ �ۉ]�<9#�����Ѥ��(��܊K��TC���s9�Ǎ�w�B�xـ-ۇB<�Ź� fK`Y���<3�zfiՠ�tll��XUͿ`��v"d�����@.�d�4r}��E}[z�h衃)���*0�F��G��ۚ|��"ǘ>��?!c�=Á���w&�����Ogq�Jٓk�j�T�u2���b���V.U��G���ٴb��.���v�xZ�ذ1L�!���ϡ��*
�gh� D�Ц�pZ�~u6�E34�;���><�� ��2������N?Aڋ]qM;C�(�
�7�0)�����-&R`�+Ih�Oe�@�5�?g�S|h�f���6���UU�y�d��H������;5�Y�q���1�`7A	�1�\rR|��;8���m�"�m�ns�~�D	
BOy<�`�C)>*Ρ9��շѵ�gr���)�]�Q~ʭldD���I�VY�z��@�4\������tN�cb��y�����	c�d~���#.�T��pb����ed����/6��F�����|s��ٳK�����K���b�$-�}_�8�M�y�V]/�����A����T�J��X�g9�!��.�i��T�R��#���o���l�)�z����W����(h9�Fg�.h�8l.��~&FF�����9N��;����3��\gz�!{Uh���"�yC�]�'<
dwC�E�k?��fGfnZ���[2=�������94Ҳ��@q��1�p�Ο�M��xu����,�ӯ�	�Z�uN��ձ?å�����,�w�G/��,�2�Lr�z[�47�O��9�Z-F}�����L�U��`�}�P��ȸ�����3��������rsyA]��rg�:A�u�>��"y?`~+�.#�k�@��~���
ʇ�hm�	tC��pM�ip:��y���p?9K�3��P)pJ���o"Yk�k��A7Ha�^C�}�i/;�k�$x�s�H�����Z�'��;���ׄߠȯ��CɱѾ�JJm����<q�A�a4v�������,�($�'���|,dL��z����G�x41��'t��Fxoݾ��7_dS�A�Edʳ����1�90�tvw���2�{ h���E�,�hRY;�S��ꕨ��c=�� \�N�nk^��e%�6��O�%�Y8+��*�6�bo'����q�D��R�yH���xO��:hi�c�>0����'l�����U'<����n˟� �L�ԁ���do�t�[�:�^�_OXH�      8   M  x����n�P�O��DM"J�B��9@A�4 ������W6uӮ�nf�L�� ˖M �6���xOvMT7�8�D�7ͥ�U]�є��Ϣ	�p#cbLO�ѐ�45��4��%&�m}�f��t*�*E�yn�$YLV�\�St�ǾeB�S�`��e�4~��h�6 ��1O�d�Jó�B��3d�M�2j�VC�#����~�ؘ�>6�:�]��'H:0���8m��q�
�����#a����pf��Mɀ�m����9����Pu�_?ן�_�c���k�+���8���]]:�-B:'iښ�z�&�B[������^7|��Z     