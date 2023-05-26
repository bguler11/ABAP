class ZCL_MUSTACHE_TEST_APP_N definition
  public
  final
  create public .

public section.

  interfaces IF_OO_ADT_CLASSRUN .

  types:
    BEGIN OF ty_shop_item,
    name TYPE string,
    price(15) TYPE p DECIMALS 2,
   END OF ty_shop_item .
  types:
    ty_shop_item_tt TYPE TABLE OF ty_shop_item WITH DEFAULT KEY .
  types:
    BEGIN OF ty_shop,
     shop_name TYPE string,
     items     TYPE ty_shop_item_tt,
    END OF ty_shop .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MUSTACHE_TEST_APP_N IMPLEMENTATION.


  METHOD IF_OO_ADT_CLASSRUN~MAIN.
    DATA lo_mustache TYPE REF TO zcl_mustache.
    DATA lt_my_data TYPE STANDARD TABLE OF ty_shop WITH DEFAULT KEY.
    DATA lr_data TYPE REF TO ty_shop.
    DATA: cx TYPE REF TO zcx_mustache_error.

    APPEND INITIAL LINE TO lt_my_data REFERENCE INTO lr_data.
    lr_data->shop_name = 'Baris Shop'.
    lr_data->items = VALUE ty_shop_item_tt( ( name = 'Terlik' price = '99.00' )
                                            ( name = 'Mintan' price = '39.00' )
                                            ( name = 'Gocuk' price = '199.00' ) ).

    APPEND INITIAL LINE TO lt_my_data REFERENCE INTO lr_data.
    lr_data->shop_name = 'Guler Shop'.
    lr_data->items = VALUE ty_shop_item_tt( ( name = 'Göynek' price = '59.00' )
                                            ( name = 'Kot Pantelon' price = '89.00' )
                                            ( name = 'Çarık'  price = '159.00' ) ).

    try.
       lo_mustache = zcl_mustache=>create(
      'Welcome to {{shop_name}}' && cl_abap_char_utilities=>newline &&
      '{{#items }}'             && cl_abap_char_utilities=>newline &&
      '* {{name}} - ${{price}}'  && cl_abap_char_utilities=>newline &&
      '{{/items}}' && cl_abap_char_utilities=>newline ).
          out->write( lo_mustache->render( lt_my_data ) ).
      catch zcx_mustache_error into cx.
          out->write( 'Error raised' ).
    endtry.






    ENDMETHOD.
ENDCLASS.
