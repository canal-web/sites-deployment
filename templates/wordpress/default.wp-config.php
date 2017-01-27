<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', '_REMOTE_SQL_DATABASE');

/** MySQL database username */
define('DB_USER', '_REMOTE_SQL_USER');

/** MySQL database password */
define('DB_PASSWORD', '_REMOTE_SQL_PASSWORD');

/** MySQL hostname */
define('DB_HOST', '_REMOTE_SQL_HOST');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
 define('AUTH_KEY',         '?$Z0w9hvgo92=$VA60(e|ww4c%%*t.?;kh:79<TakLf5(K]hJO)<<*G _-lv N;B');
 define('SECURE_AUTH_KEY',  'cI%Rk{&z{GOQ{=H;@)a5@jmQSx(YZ$JGeI@9@;97|&bTdH-/NpNS{6oAb}+,ND+M');
 define('LOGGED_IN_KEY',    '|,*DfL m,k[N#Mi?+~a.EDmAx}%-Ja2|^b:,Vt.>>A_:O^VClR(>p@s)</?U1z8A');
 define('NONCE_KEY',        'HSL=}:?8<MS.HOVU{ ~KP^LptcN`XI+rPomlpR htT14W[BiffOD+=(@R>Otd!k(');
 define('AUTH_SALT',        'L9YNA>HoQ|r*u3o+}_$$mqT+1a6 $,Y+rKF0p@2]3B4jSs5SVLEA4*jHEs=pP%W;');
 define('SECURE_AUTH_SALT', '~E-uND:#!>+:Ww~<pQ-@XDoS A,-E;or]qXR#@UFrnJJ%-aI8]@0*lX(=:@s%-Ly');
 define('LOGGED_IN_SALT',   '}K6Iu 75D@r(3p@HtI(9uV-;zS-%#ut9tCb#tOBiS_Z%K$<5<o|~91d&aJ6+rMDL');
 define('NONCE_SALT',       ',gqmdQ0Ouz=A..AJ}QDOR<4L|+[i#.`ULY#LUYQF<@T+mjrUyyW9dd|s03A,teVz');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
