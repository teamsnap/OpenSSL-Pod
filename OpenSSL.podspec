# Configuration
# Pod maintainer step 1 of 4. Modify the OPENSSL_VERSION.
OPENSSL_BASE_VERSION="1.0.2"
OPENSSL_VERSION="#{OPENSSL_BASE_VERSION}m"

# Pod maintainer step 2 of 4. Modify version and execute build script
#
#     Modify ./openssl-make.sh variables. Verify hash with the checksum
#      published on https://www.openssl.org/source/
#
#     Execute ./openssl-make.sh

# Pod maintainer step 3 of 4. Update the checksum file for built libraries
#
#     shasum lib/* > checksum
#

# Pod maintainer step 4 of 4. Update the version
#
#   In the format {openssl-version}{alphabet-number}
#   e.g. Open SSL 1.0.2m maps to 1.0.213.  1.0.2 from version, "m" is the 13th
#    letter in the alphabet.
#
#  https://www.worldometers.info/languages/how-many-letters-alphabet/
#  Prepend single-digit alphabet numbers with zero (9 is 09) to create a
#  minimum 3-digit patch version.

Pod::Spec.new do |s|
  s.name            = "OpenSSL"
  s.version         = "#{OPENSSL_BASE_VERSION}13"
  s.summary         = "OpenSSL is an SSL/TLS and Crypto toolkit. Deprecated in Mac OS and gone in iOS, this spec gives your project non-deprecated OpenSSL support."
  s.author          = "OpenSSL Project <openssl-dev@openssl.org>"
  s.source          = { http: "https://www.openssl.org/source/openssl-#{OPENSSL_VERSION}.tar.gz", sha256: "8c6ff15ec6b319b50788f42c7abc2890c08ba5a1cdcd3810eb9092deada37b0f" }
  s.homepage        = "https://github.com/WhisperSystems/OpenSSL-Pod"
  s.source_files    = "opensslIncludes/openssl/*.h"
  s.header_dir      = "openssl"
  s.license         = { :type => 'OpenSSL (OpenSSL/SSLeay)', :file => 'LICENSE' }

  s.ios.deployment_target   = "11.0"
  s.ios.public_header_files = "opensslIncludes/openssl/*.h"
  s.ios.vendored_libraries  = "lib/libcrypto.a", "lib/libssl.a"

  s.libraries             = 'crypto', 'ssl'
  s.requires_arc          = false
  s.prepare_command       = "shasum -c checksum"
end
