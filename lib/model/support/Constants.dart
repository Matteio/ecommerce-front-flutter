
import 'dart:ui';

enum SortTipi{ CRES, DECR, }

enum GetTipi{ FILTRA, PAGINAZIONE, }

class Constants {
  // app info
  static final String APP_VERSION = "0.0.1";
  static final String APP_NAME = "shopSite";

  // addresses
  static final String ADDRESS_STORE_SERVER = "localhost:8000";
  static final String ADDRESS_AUTHENTICATION_SERVER = "localhost:8080";

  // authentication
  static final String REALM = "shop";
  static final String CLIENT_ID = "shop-client";
  static final String CLIENT_SECRET = "k7xwjrx81N16w3OnkQkq00NepKjlimhM";
  static final String REQUEST_LOGIN = "auth/realms/" + REALM + "/protocol/openid-connect/token";
  static final String REQUEST_LOGOUT = "auth/realms/" + REALM + "/protocol/openid-connect/logout";


  // requests
  static final String REQUEST_SEARCH_PRODUCTS_PAGED = "/prodotti/getAll/paged" ;
  static final String REQUEST_SEARCH_PRODUCTS_BY_NAME = "/prodotti/getByName" ;
  static final String REQUEST_SEARCH_PRODUCTS_ALL = "/prodotti/getAll" ;
  static final String REQUEST_REGISTER_USER = "/r";
  static final String REQUEST_EDIT_PRODUCTS="/prodotti/admin/edit";
  static final String REQUEST_ADD_PRODUCTS="/prodotti/admin/add";
  static final String REQUEST_DELETE_PRODUCTS="/prodotti/admin/delete/"; // +{idProdotto}
  static final String REQUEST_ADD_TO_CART="/utenti/addToCart";
  static final String REQUEST_SET_QTY_TO_CART="/utenti/setQuantityToCart";
  static final String REQUEST_REMOVE_FROM_CART="/utenti/removeFromCart";
  static final String REQUEST_GET_CART="/utenti/getCart";
  static final String REQUEST_COMPRA_PR="/prodotti/compra";
  static final String REQUEST_COMPRA_CART="/prodotti/acquistaCart";
  static final String REQUEST_GET_ACQUISTI="/acquisto/getAcquisti";
  static final String REQUEST_SET_DONE="/acquisto/setAcquistoDone";


  // states
  static final String STATE_CLUB = "club";
  static const int PAGE_LIMIT=10;

  // responses
  static final String RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS = "ERROR_MAIL_USER_ALREADY_EXISTS";
  static final String RESPONSE_ERROR_USER_NOT_FOUND="ERROR_USER_NOT_FOUND";
  static final String RESPONSE_ERROR_QUANTITY_PRODUCT_UNAVAILABLE="ERROR_QUANTITY_PRODUCT_UNAVAILABLE";
  static final String RESPONSE_ERROR_PRODUCT_NOT_FOUND="ERROR_PRODUCT_NOT_FOUND";
  static const String RESPONSE_ERROR_CART_IS_EMPTY = "CartIsEmptyException";

  // messages
  static final String MESSAGE_CONNECTION_ERROR = "connection_error";

  //color
  static final textColor = Color(0xFF535353);
  static final textLightColor = Color(0xFFACACAC);

}//Constants