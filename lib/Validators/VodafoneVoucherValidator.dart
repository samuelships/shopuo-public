final vodafoneVoucherValidators = [
  (value) => value.isNotEmpty ? null : "This field is required",
  (value) => value.length != 6 ? null : "Voucher length is invalid",
];
