class OxygenDurationModel {
  Psi? p600si;
  Psi? p800Psi;
  Psi? p1000Psi;
  Psi? p1200Psi;
  Psi? p1400Psi;
  Psi? p1500Psi;
  Psi? p1800Psi;
  Psi? p2000Psi;

  OxygenDurationModel(
      {this.p600si,
      this.p800Psi,
      this.p1000Psi,
      this.p1200Psi,
      this.p1400Psi,
      this.p1500Psi,
      this.p1800Psi,
      this.p2000Psi});

  OxygenDurationModel.fromJson(Map<String, dynamic> json) {
    p600si = json['600 psi'] != null ? new Psi.fromJson(json['600 psi']) : null;
    p800Psi =
        json['800 psi'] != null ? new Psi.fromJson(json['800 psi']) : null;
    p1000Psi =
        json['1000 psi'] != null ? new Psi.fromJson(json['1000 psi']) : null;
    p1200Psi =
        json['1200 psi'] != null ? new Psi.fromJson(json['1200 psi']) : null;
    p1400Psi =
        json['1400 psi'] != null ? new Psi.fromJson(json['1400 psi']) : null;
    p1500Psi =
        json['1500 psi'] != null ? new Psi.fromJson(json['1500 psi']) : null;
    p1800Psi =
        json['1800 psi'] != null ? new Psi.fromJson(json['1800 psi']) : null;
    p2000Psi =
        json['2000 psi'] != null ? new Psi.fromJson(json['2000 psi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.p600si != null) {
      data['600 psi'] = this.p600si!.toJson();
    }
    if (this.p800Psi != null) {
      data['800 psi'] = this.p800Psi!.toJson();
    }
    if (this.p1000Psi != null) {
      data['1000 psi'] = this.p1000Psi!.toJson();
    }
    if (this.p1200Psi != null) {
      data['1200 psi'] = this.p1200Psi!.toJson();
    }
    if (this.p1400Psi != null) {
      data['1400 psi'] = this.p1400Psi!.toJson();
    }
    if (this.p1500Psi != null) {
      data['1500 psi'] = this.p1500Psi!.toJson();
    }
    if (this.p1800Psi != null) {
      data['1800 psi'] = this.p1800Psi!.toJson();
    }
    if (this.p2000Psi != null) {
      data['2000 psi'] = this.p2000Psi!.toJson();
    }
    return data;
  }
}

class Psi {
  List<String>? l5L;
  List<String>? l10L;
  List<String>? l15L;
  List<String>? l20L;
  List<String>? l25L;
  List<String>? l30L;
  List<String>? l35L;
  List<String>? l40L;

  Psi(
      {this.l5L,
      this.l10L,
      this.l15L,
      this.l20L,
      this.l25L,
      this.l30L,
      this.l35L,
      this.l40L});

  Psi.fromJson(Map<String, dynamic> json) {
    l5L = json['5 L'].cast<String>();
    l10L = json['10 L'].cast<String>();
    l15L = json['15 L'].cast<String>();
    l20L = json['20 L'].cast<String>();
    l25L = json['25 L'].cast<String>();
    l30L = json['30 L'].cast<String>();
    l35L = json['35 L'].cast<String>();
    l40L = json['40 L'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['5 L'] = this.l5L;
    data['10 L'] = this.l10L;
    data['15 L'] = this.l15L;
    data['20 L'] = this.l20L;
    data['25 L'] = this.l25L;
    data['30 L'] = this.l30L;
    data['35 L'] = this.l35L;
    data['40 L'] = this.l40L;
    return data;
  }
}
