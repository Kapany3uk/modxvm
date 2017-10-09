""" XVM (c) www.modxvm.com 2013-2017 """
# This Python file uses the following encoding: utf-8
from xfw import *

from logger import *


# PUBLIC

def getShortName(key, level, vclass):
    if IS_DEVELOPMENT:
        global _data
        if key not in _data:
            log('Warning: no short vehicle name for "{}" level={} class={}'.format(key, level, vclass))
    return _data.get(key, None)


def checkNames(vehs):
    if IS_DEVELOPMENT:
        global _data
        for key in _data:
            if not any(x['key'] == key for x in vehs):
                log('Warning: short name for non-existent vehicle "{}"'.format(key))


# PRIVATE

_data = {
    # Last update: 09.10.2017
    "china:Ch01_Type59":                     'Typ59',
    "china:Ch01_Type59_Gold":                'Typ59g',
    "china:Ch02_Type62":                     'Typ62',
    "china:Ch03_WZ-111":                     '111',
    "china:Ch03_WZ_111_A":                   '111',
    "china:Ch04_T34_1":                      't34·1',
    "china:Ch05_T34_2":                      't34·2',
    "china:Ch06_Renault_NC31":               'NC31',
    "china:Ch06_Renault_NC31_bot":           'NC31',
    "china:Ch07_Vickers_MkE_Type_BT26":      'TypB',
    "china:Ch08_Type97_Chi_Ha":              'ChiHa',
    "china:Ch08_Type97_Chi_Ha_bootcamp":     'ChiHa',
    "china:Ch09_M5":                         'ChM5',
    "china:Ch10_IS2":                        'IS2',
    "china:Ch11_110":                        '110',
    "china:Ch11_110_IGR":                    '110',
    "china:Ch12_111_1_2_3":                  '111·4',
    "china:Ch14_T34_3":                      't34·3',
    "china:Ch15_59_16":                      '59·16',
    "china:Ch16_WZ_131":                     'wz131',
    "china:Ch17_WZ131_1_WZ132":              'wz132',
    "china:Ch17_WZ131_1_WZ132_IGR":          'wz132',
    "china:Ch18_WZ-120":                     'wz120',
    "china:Ch19_121":                        '121',
    "china:Ch19_121_IGR":                    '121',
    "china:Ch20_Type58":                     'Typ58',
    "china:Ch21_T34":                        'tp·t34',
    "china:Ch22_113":                        '113',
    "china:Ch22_113P":                       '113',
    "china:Ch22_113_Beijing_Opera":          '113·bo',
    "china:Ch23_112":                        '112',
    "china:Ch24_Type64":                     'Typ64',
    "china:Ch25_121_mod_1971B":              '121B',
    "china:Ch26_59_Patton":                  '59Pat',
    "china:Ch28_WZ_132A":                    'wz132a',
    "china:Ch29_Type_62C_prot":              'wz132·1',
    "china:Ch30_T-26G_FT":                   't26g·ft',
    "china:Ch31_M3G_FT":                     'm3g·ft',
    "china:Ch32_SU-76G_FT":                  'su76g·ft',
    "china:Ch33_60G_FT":                     '60g·ft',
    "china:Ch34_WZ131G_FT":                  '131g·ft',
    "china:Ch35_T-34-2G_FT":                 't34·2g·ft',
    "china:Ch36_WZ111_1G_FT":                '111·1·ft',
    "china:Ch37_WZ111G_FT":                  '111g·ft',
    "china:Ch38_WZ113G_FT":                  '113g·ft',
    "china:Ch39_WZ120_1G_FT":                '120·1ft',
    "china:Ch40_WZ120G_FT":                  '120G·ft',
    "china:Ch41_WZ_111_5A":                  '111·5a',
    "czech:Cz01_Skoda_T40":                  'skT40',
    "czech:Cz02_TVP_T50":                    'skT50',
    "czech:Cz03_LT_vz35":                    'vz.35',
    "czech:Cz04_T50_51":                     'skT50·51',
    "czech:Cz05_T34_100":                    't34·100',
    "czech:Cz06_Kolohousenka":               'khous',
    "czech:Cz07_TVP_46":                     'vtu',
    "czech:Cz08_T_25":                       'skT25',
    "czech:Cz09_T_24":                       'skT24',
    "czech:Cz10_LT_vz38":                    'vz.38',
    "czech:Cz11_V_8_H":                      'vz.39',
    "france:F01_RenaultFT":                  'FT',
    "france:F01_RenaultFT_bot":              'FT',
    "france:F02_D1":                         'D1',
    "france:F03_D2":                         'D2',
    "france:F04_B1":                         'B1',
    "france:F04_B1_bootcamp":                'B1',
    "france:F05_BDR_G1B":                    'BDR',
    "france:F06_ARL_44":                     'Arl44',
    "france:F07_AMX_M4_1945":                'amx4·45',
    "france:F08_AMX_50_100":                 '50100',
    "france:F08_AMX_50_100_IGR":             '50100',
    "france:F09_AMX_50_120":                 '50120',
    "france:F10_AMX_50B":                    '50B',
    "france:F10_AMX_50B_fallout":            '50B',
    "france:F11_Renault_G1R":                'G1R',
    "france:F12_Hotchkiss_H35":              'h35',
    "france:F13_AMX38":                      'amx38',
    "france:F14_AMX40":                      'amx40',
    "france:F15_AMX_12t":                    'amx12',
    "france:F16_AMX_13_75":                  '13·75',
    "france:F17_AMX_13_90":                  '13·90',
    "france:F17_AMX_13_90_IGR":              '13·90',
    "france:F18_Bat_Chatillon25t":           'BChat',
    "france:F18_Bat_Chatillon25t_IGR":       'BChat',
    "france:F19_Lorraine40t":                'Lr40t',
    "france:F20_RenaultBS":                  'ftBS',
    "france:F21_Lorraine39_L_AM":            '39Lam',
    "france:F22_AMX_105AM":                  '13AM',
    "france:F23_AMX_13F3AM":                 '13F3',
    "france:F24_Lorraine155_50":             '155·50',
    "france:F25_Lorraine155_51":             '155·51',
    "france:F27_FCM_36Pak40":                'Pak40',
    "france:F28_105_leFH18B2":               'leFH',
    "france:F28_105_leFH18B2_IGR":           'leFH',
    "france:F30_RenaultFT_AC":               'ftAC',
    "france:F32_Somua_Sau_40":               'SAu40',
    "france:F33_S_35CA":                     'S35ca',
    "france:F33_S_35CA_IGR":                 'S35ca',
    "france:F34_ARL_V39":                    'Arl39',
    "france:F35_AMX_AC_Mle1946":             'amx46',
    "france:F36_AMX_AC_Mle1948":             'amx48',
    "france:F36_AMX_AC_Mle1948_IGR":         'amx48',
    "france:F37_AMX50_Foch":                 'Foch',
    "france:F38_Bat_Chatillon155_58":        '155·58',
    "france:F44_Somua_S35":                  'SomS35',
    "france:F49_RenaultR35":                 'R35',
    "france:F50_FCM36_20t":                  'fcm36',
    "france:F52_RenaultUE57":                'UE57',
    "france:F62_ELC_AMX":                    'ELC',
    "france:F62_ELC_AMX_IGR":                'ELC',
    "france:F64_AMX_50Fosh_155":             'Fch155',
    "france:F64_AMX_50Fosh_B":               'Fch·B',
    "france:F65_FCM_50t":                    'fcm50t',
    "france:F66_AMX_Ob_Am105":               '105AM',
    "france:F67_Bat_Chatillon155_55":        '155·55',
    "france:F68_AMX_Chasseur_de_char_46":    'CDC',
    "france:F69_AMX13_57_100":               '13·57',
    "france:F69_AMX13_57_100_GrandFinal":    '13·57·GF',
    "france:F70_SARL42":                     'sarl42',
    "france:F71_AMX_30_prototype":           'amx30',
    "france:F72_AMX_30":                     'amx30b',
    "france:F73_M4A1_Revalorise":            'm4a1',
    "france:F74_AMX_M4_1949":                'amx4·49',
    "france:F74_AMX_M4_1949_Liberte":        'amx4·49',
    "france:F75_Char_de_25t":                'BChatAP',
    "france:F84_Somua_SM":                   'Som·SM',
    "france:F87_Batignolles-Chatillon_12t":  'BChat12t',
    "france:F88_AMX_13_105":                 '13·105',
    "france:F89_Canon_dassaut_de_105":       'amx·cda',
    "germany:Env_Artillery":                 'E.Art',
    "germany:G02_Hummel":                    'Humml',
    "germany:G03_PzV_Panther":               'Pant',
    "germany:G03_PzV_Panther_IGR":           'Pant',
    "germany:G03_PzV_Panther_bootcamp":      'Pant',
    "germany:G04_PzVI_Tiger_I":              'Tig1',
    "germany:G04_PzVI_Tiger_IA":             'Tig1a',
    "germany:G04_PzVI_Tiger_I_IGR":          'Tig1',
    "germany:G05_StuG_40_AusfG":             'StugG',
    "germany:G05_StuG_40_AusfG_IGR":         'StugG',
    "germany:G06_PzII":                      'Pz2',
    "germany:G06_PzII_bot":                  'Pz2',
    "germany:G07_Pz35t":                     'Pz35t',
    "germany:G08_Pz38t":                     'Pz38t',
    "germany:G08_Pz38t_bootcamp":            'Pz38t',
    "germany:G09_Hetzer":                    'Hetzr',
    "germany:G100_Gtraktor_Krupp":           'GrTr',
    "germany:G101_StuG_III":                 'StugB',
    "germany:G102_Pz_III":                   'Pz3e',
    "germany:G102_Pz_III_bootcamp":          'Pz3e',
    "germany:G103_RU_251":                   'Ru251',
    "germany:G104_Stug_IV":                  'Stug4',
    "germany:G105_T-55_NVA_DDR":             'T·55a',
    "germany:G106_PzKpfwPanther_AusfF":      'Pant88',
    "germany:G107_PzKpfwIII_AusfK":          'Pz3k',
    "germany:G108_PzKpfwII_AusfD":           'Pz2d',
    "germany:G109_Steyr_WT":                 'WTstr',
    "germany:G10_PzIII_AusfJ":               'Pz3',
    "germany:G110_Typ_205":                  'Mausch',
    "germany:G112_KanonenJagdPanzer":        'KnJpz',
    "germany:G112_KanonenJagdPanzer_105":    'KnJpz',
    "germany:G113_SP_I_C":                   'sp1c',
    "germany:G114_Rheinmetall_Skorpian":     'skorp',
    "germany:G114_Skorpian":                 'skorp',
    "germany:G115_Typ_205B":                 '100.01p',
    "germany:G115_Typ_205_4_Jun":            'vk100',
    "germany:G116_Turan_III_prot":           'Turn3',
    "germany:G117_Toldi_III":                'Told3',
    "germany:G117_Toldi_III_bootcamp":       'Told3',
    "germany:G118_VK4503":                   '4503',
    "germany:G119_Panzer58":                 'Pz58',
    "germany:G119_Panzer58_BF":              'Pz58bf',    
    "germany:G119_Pz58_Mutz":                'mutz',
    "germany:G11_Bison_I":                   'Bison',
    "germany:G120_M41_90":                   'M41·90',
    "germany:G120_M41_90_GrandFinal":        'M41·90·GF',
    "germany:G121_Grille_15_L63":            'Grill15',
    "germany:G122_VK6501H":                  '6501h',
    "germany:G125_Spz_57_Rh":                'Rhm.Pzw',
    "germany:G126_HWK_12":                   'HWK12',
    "germany:G12_Ltraktor":                  'Ltr',
    "germany:G12_Ltraktor_bot":              'Ltr',
    "germany:G134_PzKpfw_VII":               'PzKf·VII',
    "germany:G136_Tiger_131":                'Tig131',
    "germany:G137_PzVI_Tiger_217":           'Tig217',
    "germany:G138_VK168_02":                 '168.01p',
    "germany:G13_VK3001H":                   '3001h',
    "germany:G15_VK3601H":                   '3601h',
    "germany:G16_PzVIB_Tiger_II":            'Tig2',
    "germany:G16_PzVIB_Tiger_II_F":          'Tig2·h',
    "germany:G16_PzVIB_Tiger_II_IGR":        'Tig2',
    "germany:G17_JagdPzIV":                  'Jpz4',
    "germany:G18_JagdPanther":               'JagPnt',
    "germany:G19_Wespe":                     'Wespe',
    "germany:G20_Marder_II":                 'Mrdr2',
    "germany:G21_PanzerJager_I":             'PzJg1',
    "germany:G21_PanzerJager_I_bootcamp":    'PzJg1',
    "germany:G22_Sturmpanzer_II":            'StPz2',
    "germany:G23_Grille":                    'Grill',
    "germany:G24_VK3002DB":                  '3002d',
    "germany:G25_PzII_Luchs":                'Luchs',
    "germany:G26_VK1602":                    'Leo',
    "germany:G27_VK3001P":                   '3001p',
    "germany:G28_PzIII_IV":                  'Pz3·4',
    "germany:G32_PzV_PzIV":                  'Pz5·4',
    "germany:G32_PzV_PzIV_CN":               'Pz5·BP',
    "germany:G32_PzV_PzIV_ausf_Alfa":        'Pz5·4a',
    "germany:G32_PzV_PzIV_ausf_Alfa_CN":     'Pz5·BPa',
    "germany:G33_H39_captured":              'Pz38h',
    "germany:G34_S35_captured":              'PzS35',
    "germany:G35_B-1bis_captured":           'PzB2',
    "germany:G36_PzII_J":                    'Pz2j',
    "germany:G37_Ferdinand":                 'Ferd',
    "germany:G37_Ferdinand_IGR":             'Ferd',
    "germany:G39_Marder_III":                'Mrdr38',
    "germany:G40_Nashorn":                   'Nash',
    "germany:G41_DickerMax":                 'DMax',
    "germany:G42_Maus":                      'Maus',
    "germany:G42_Maus_IGR":                  'Maus',
    "germany:G43_Sturer_Emil":               'Emil',
    "germany:G44_JagdTiger":                 'JagT',
    "germany:G44_JagdTigerH":                'JagT·h',
    "germany:G45_G_Tiger":                   'GWT',
    "germany:G46_T-25":                      'T·25',
    "germany:G48_E-25":                      'E·25',
    "germany:G48_E-25_IGR":                  'E·25',
    "germany:G49_G_Panther":                 'GWP',
    "germany:G50_T-15":                      'T·15',
    "germany:G51_Lowe":                      'Lowe',
    "germany:G52_Pz38_NA":                   'Pz38na',
    "germany:G53_PzI":                       'Pz1',
    "germany:G54_E-50":                      'E·50',
    "germany:G55_E-75":                      'E·75',
    "germany:G56_E-100":                     'E·100',
    "germany:G57_PzVI_Tiger_P":              'TigP',
    "germany:G58_VK4502P":                   '4502b',
    "germany:G58_VK4502P7":                  '4502b7',
    "germany:G61_G_E":                       'GWE',
    "germany:G63_PzI_ausf_C":                'Pz1c',
    "germany:G64_Panther_II":                'Pant2',
    "germany:G64_Panther_II_IGR":            'Pant2',
    "germany:G65_JagdTiger_SdKfz_185":       'JgT88',
    "germany:G65_JagdTiger_SdKfz_185_IGR":   'JgT88',
    "germany:G66_VK2801":                    'vk2801',
    "germany:G67_VK4502A":                   '4502a',
    "germany:G70_PzIV_Hydro":                'Pz4hy',
    "germany:G71_JagdPantherII":             'JagP2',
    "germany:G72_JagdPz_E100":               'Jpz100',
    "germany:G73_E50_Ausf_M":                'E·50m',
    "germany:G76_Pz_Sfl_IVc":                'PzS4c',
    "germany:G77_PzIV_Schmalturm":           'Pz4s',
    "germany:G78_Panther_M10":               'PanM10',
    "germany:G79_Pz_IV_AusfGH":              'Pz4',
    "germany:G80_Pz_IV_AusfD":               'Pz4d',
    "germany:G80_Pz_IV_AusfD_bootcamp":      'Pz4d',
    "germany:G81_Pz_IV_AusfH":               'Pz4h',
    "germany:G82_Pz_II_AusfG":               'Pz2g',
    "germany:G83_Pz_IV_AusfA":               'Pz4a',
    "germany:G85_Auf_Panther":               'AufPan',
    "germany:G86_VK2001DB":                  'vk2001',
    "germany:G87_VK3002DB_V1":               '3001d',
    "germany:G88_Indien_Panzer":             'IndPz',
    "germany:G89_Leopard1":                  'Leo1',
    "germany:G90_DW_II":                     'DW2',
    "germany:G91_Pro_Ag_A":                  'LeoPrA',
    "germany:G92_VK7201":                    'vk7201',
    "germany:G93_GW_Mk_VIe":                 'Gpz·VI',
    "germany:G94_GW_Tiger_P":                'GWTP',
    "germany:G95_Pz_Sfl_IVb":                'PzS4b',
    "germany:G96_VK3002M":                   '3002m',
    "germany:G97_Waffentrager_IV":           'WT4',
    "germany:G98_Waffentrager_E100":         'WT100',
    "germany:G98_Waffentrager_E100_P":       'WT100p',
    "germany:G99_RhB_Waffentrager":          'WTRhB',
    "japan:J01_NC27":                        'R.Ots',
    "japan:J01_NC27_bot":                    'R.Ots',
    "japan:J02_Te_Ke":                       'TeKe',
    "japan:J03_Ha_Go":                       'HaGo',
    "japan:J04_Ke_Ni":                       'KeNi',
    "japan:J04_Ke_Ni_bootcamp":              'KeNi',
    "japan:J05_Ke_Ni_B":                     'KeNiO',
    "japan:J06_Ke_Ho":                       'KeHo',
    "japan:J07_Chi_Ha":                      'JChiHa',
    "japan:J08_Chi_Nu":                      'ChiNu',
    "japan:J09_Chi_He":                      'ChiHe',
    "japan:J10_Chi_To":                      'ChiTo',
    "japan:J11_Chi_Ri":                      'ChiRi',
    "japan:J11_Chi_Ri_IGR":                  'ChiRi',
    "japan:J12_Chi_Nu_Kai":                  'ChiNuK',
    "japan:J13_STA_1":                       'sta·1',
    "japan:J13_STA_1_IGR":                   'sta·1',
    "japan:J14_Type_61":                     'Typ61',
    "japan:J15_Chi_Ni":                      'ChiNi',
    "japan:J16_ST_B1":                       'stb·1',
    "japan:J16_ST_B1_IGR":                   'stb·1',
    "japan:J18_STA_2_3":                     'sta·2',
    "japan:J19_Tiger_I_Jpn":                 'JapTig',
    "japan:J20_Type_2605":                   'Typ5',
    "japan:J21_Type_91":                     'Typ91',
    "japan:J22_Type_95":                     'Typ95',
    "japan:J22_Type_95_bootcamp":            'Typ95',
    "japan:J23_Mi_To":                       'O·Iex',
    "japan:J24_Mi_To_130_tons":              'O·I',
    "japan:J25_Type_4":                      'Typ4',
    "japan:J26_Type_89":                     'I·go',
    "japan:J27_O_I_120":                     'O·ho',
    "japan:J28_O_I_100":                     'O·ni',
    "japan:J29_Nameless":                    'Namel',
    "japan:J30_Edelweiss":                   'Edelw',
    "poland:Pl03_PzV_Poland":                'Pudel',
    "sweden:S01_Strv_74_A2":                 'm42·57',
    "sweden:S02_Strv_M42":                   'm/42',
    "sweden:S03_Strv_M38":                   'm/38',
    "sweden:S04_Lago_I":                     'lago',
    "sweden:S05_Strv_M21_29":                'fm/21',
    "sweden:S06_Ikv_90_Typ_B_Bofors":        'lkv90·b',
    "sweden:S07_Strv_74":                    'strv·74',
    "sweden:S08_Ikv_65_Alt_2":               'lkv60·2',
    "sweden:S09_L_120_TD":                   'fm/42',
    "sweden:S10_Strv_103_0_Series":          '103·0',
    "sweden:S11_Strv_103B":                  '103·b',
    "sweden:S12_Strv_M40":                   'm/40L',
    "sweden:S13_Leo":                        'leo',
    "sweden:S14_Ikv_103":                    'lkv103',
    "sweden:S15_L_60":                       'L60',
    "sweden:S16_Kranvagn":                   'kranv',
    "sweden:S17_EMIL_1952_E2":               'emil·II',
    "sweden:S18_EMIL_1951_E1":               'emil·I',
    "sweden:S19_Sav_M43":                    'm/43',
    "sweden:S20_Ikv_72":                     'lkv72',
    "sweden:S21_UDES_03":                    'udes·03',
    "sweden:S22_Strv_S1":                    'strv·S1',
    "sweden:S23_Strv_81":                    'strv·81',
    "sweden:S23_Strv_81_sabaton":            'Pr.Vict',
    "uk:GB01_Medium_Mark_I":                 'Med1',
    "uk:GB01_Medium_Mark_I_bot":             'Med1',
    "uk:GB03_Cruiser_Mk_I":                  'Crus1',
    "uk:GB04_Valentine":                     'Valnt',
    "uk:GB05_Vickers_Medium_Mk_II":          'Med2',
    "uk:GB05_Vickers_Medium_Mk_II_bot":      'Med2',
    "uk:GB06_Vickers_Medium_Mk_III":         'Med3',
    "uk:GB07_Matilda":                       'Matil',
    "uk:GB08_Churchill_I":                   'Chrch1',
    "uk:GB08_Churchill_I_IGR":               'Chrch1',
    "uk:GB09_Churchill_VII":                 'Chrch7',
    "uk:GB10_Black_Prince":                  'BlPrn',
    "uk:GB11_Caernarvon":                    'Caer',
    "uk:GB11_Caernarvon_IGR":                'Caer',
    "uk:GB12_Conqueror":                     'Conq',
    "uk:GB13_FV215b":                        'Fv215',
    "uk:GB13_FV215b_IGR":                    'Fv215',
    "uk:GB14_M2":                            'M2',
    "uk:GB15_Stuart_I":                      'stu-1·4',
    "uk:GB17_Grant_I":                       'Grant',
    "uk:GB19_Sherman_Firefly":               'Firef',
    "uk:GB20_Crusader":                      'Crsdr',
    "uk:GB21_Cromwell":                      'Cromw',
    "uk:GB21_Cromwell_IGR":                  'Cromw',
    "uk:GB22_Comet":                         'Comet',
    "uk:GB23_Centurion":                     'Cent',
    "uk:GB23_Centurion_IGR":                 'Cent',
    "uk:GB24_Centurion_Mk3":                 'Cent7',
    "uk:GB25_Loyd_Gun_Carriage":             'LoydG',
    "uk:GB26_Birch_Gun":                     'Birch',
    "uk:GB27_Sexton":                        'Sext2',
    "uk:GB28_Bishop":                        'Bish',
    "uk:GB29_Crusader_5inch":                'CruSP',
    "uk:GB30_FV3805":                        'fv3805',
    "uk:GB31_Conqueror_Gun":                 'ConqG',
    "uk:GB32_Tortoise":                      'Tort',
    "uk:GB33_Sentinel_AC_I":                 'Sentw',
    "uk:GB35_Sentinel_AC_IV":                'SentAC',
    "uk:GB39_Universal_CarrierQF2":          'QF2',
    "uk:GB40_Gun_Carrier_Churchill":         'ChrGC',
    "uk:GB41_Challenger":                    'Chall',
    "uk:GB42_Valentine_AT":                  'ValAT',
    "uk:GB44_Archer":                        'Arch',
    "uk:GB45_Achilles_IIC":                  'Achil',
    "uk:GB48_FV215b_183":                    'Fv183',
    "uk:GB50_Sherman_III":                   'Sherm3',
    "uk:GB51_Excelsior":                     'Excel',
    "uk:GB52_A45":                           'fv201',
    "uk:GB57_Alecto":                        'Alect',
    "uk:GB58_Cruiser_Mk_III":                'Crus3',
    "uk:GB59_Cruiser_Mk_IV":                 'Crus4',
    "uk:GB60_Covenanter":                    'Coven',
    "uk:GB63_TOG_II":                        'TOG2',
    "uk:GB68_Matilda_Black_Prince":          'MatBP',
    "uk:GB69_Cruiser_Mk_II":                 'Crus3',
    "uk:GB70_FV4202_105":                    'fv4202',
    "uk:GB70_N_FV4202_105":                  'fv4202p',
    "uk:GB71_AT_15A":                        'AT15a',
    "uk:GB72_AT15":                          'AT15',
    "uk:GB72_AT15_IGR":                      'AT15',
    "uk:GB73_AT2":                           'AT2',
    "uk:GB74_AT8":                           'AT8',
    "uk:GB75_AT7":                           'AT7',
    "uk:GB76_Mk_VIC":                        'L.vic',
    "uk:GB77_FV304":                         'fv304',
    "uk:GB77_FV304_IGR":                     'fv304',
    "uk:GB78_Sexton_I":                      'Sext1',
    "uk:GB79_FV206":                         'fv207',
    "uk:GB80_Charioteer":                    'Chari',
    "uk:GB81_FV4004":                        'Conw',
    "uk:GB83_FV4005":                        'fv4005',
    "uk:GB84_Chieftain_Mk6":                 'Chief',
    "uk:GB85_Cromwell_Berlin":               'cromwB',
    "uk:GB86_Centurion_Action_X":            'CentAX',
    "uk:GB87_Chieftain_T95_turret":          'Chief/T95',
    "uk:GB88_T95_Chieftain_turret":          'T95/Chief',
    "uk:GB91_Super_Conqueror":               'S.Conq',
    "usa:A01_T1_Cunningham":                 'T1',
    "usa:A01_T1_Cunningham_bot":             'T1',
    "usa:A02_M2_lt":                         'M2lt',
    "usa:A03_M3_Stuart":                     'M3stu',
    "usa:A03_M3_Stuart_bootcamp":            'M3stu',
    "usa:A04_M3_Grant":                      'M3Lee',
    "usa:A05_M4_Sherman":                    'M4',
    "usa:A05_M4_Sherman_IGR":                'M4',
    "usa:A06_M4A3E8_Sherman":                'M4a3e8',
    "usa:A07_T20":                           'T20',
    "usa:A08_T23":                           'T23',
    "usa:A09_T1_hvy":                        'T1hv',
    "usa:A100_T49":                          'T49',
    "usa:A101_M56":                          'Scorp',
    "usa:A102_T28_concept":                  'T28c',
    "usa:A103_T71E1":                        'T71da',
    "usa:A103_T71E1_IGR":                    'T71da',
    "usa:A104_M4A3E8A":                      'Fury',
    "usa:A106_M48A2_120":                    '54E2',
    "usa:A107_T1_HMC":                       'T1hmc',
    "usa:A108_T18_HMC":                      'T18hmc',
    "usa:A109_T56_GMC":                      'T56gmc',
    "usa:A10_M6":                            'M6',
    "usa:A111_T25_Pilot":                    'T25PN1',
    "usa:A112_T71E2":                        'T71cm·P',
    "usa:A112_T71E2R":                       'T71cm',
    "usa:A115_Chrysler_K":                   'ChrysK',
    "usa:A116_XM551":                        'Sheri',
    "usa:A117_T26E5":                        'T26e5',
    "usa:A117_T26E5_Patriot":                'T26e5',
    "usa:A118_M4_Thunderbolt":               'Thund.bt',
    "usa:A11_T29":                           'T29',
    "usa:A11_T29_IGR":                       'T29',
    "usa:A120_M48A5":                        'M48Pt',
    "usa:A120_M48A5_IGR":                    'M48Pt',
    "usa:A12_T32":                           'T32',
    "usa:A13_T34_hvy":                       'T34',
    "usa:A13_T34_hvy_BF":                    'T34bf',
    "usa:A13_T34_hvy_IGR":                   'T34',
    "usa:A14_T30":                           'T30',
    "usa:A15_T57":                           'T57',
    "usa:A16_M7_Priest":                     'Prist',
    "usa:A17_M37":                           'M37',
    "usa:A18_M41":                           'M41',
    "usa:A19_T2_lt":                         'T2lt',
    "usa:A21_T14":                           'T14',
    "usa:A22_M5_Stuart":                     'M5stu',
    "usa:A22_M5_Stuart_bootcamp":            'M5stu',
    "usa:A23_M7_med":                        'M7',
    "usa:A24_T2_med":                        'T2med',
    "usa:A24_T2_med_bot":                    'T2med',
    "usa:A25_M2_med":                        'M2med',
    "usa:A25_M2_med_bootcamp":               'M2med',
    "usa:A26_T18":                           'T18',
    "usa:A27_T82":                           'T82hmc',
    "usa:A29_T40":                           'T40',
    "usa:A30_M10_Wolverine":                 'Wolvr',
    "usa:A31_M36_Slagger":                   'Jacks',
    "usa:A32_M12":                           'M12',
    "usa:A33_MTLS-1G14":                     'mtls',
    "usa:A34_M24_Chaffee":                   'Chaff',
    "usa:A35_Pershing":                      'Persh',
    "usa:A35_Pershing_IGR":                  'Persh',
    "usa:A36_Sherman_Jumbo":                 'Jumbo',
    "usa:A36_Sherman_Jumbo_IGR":             'Jumbo',
    "usa:A36_Sherman_Jumbo_bootcamp":        'Jumbo',
    "usa:A37_M40M43":                        'M40·43',
    "usa:A38_T92":                           'T92',
    "usa:A39_T28":                           'T28',
    "usa:A40_T95":                           'T95',
    "usa:A41_M18_Hellcat":                   'Hellc',
    "usa:A43_M22_Locust":                    'Locst',
    "usa:A44_M4A2E4":                        'M4a2e4',
    "usa:A45_M6A2E1":                        'M6a2e1',
    "usa:A46_T3":                            'T3hmc',
    "usa:A57_M8A1":                          'M8a1',
    "usa:A58_T67":                           'T67',
    "usa:A58_T67_IGR":                       'T67',
    "usa:A62_Ram-II":                        'Ram2',
    "usa:A63_M46_Patton":                    'M46Pt',
    "usa:A63_M46_Patton_KR":                 'M46PtKR',
    "usa:A64_T25_AT":                        'T25at',
    "usa:A66_M103":                          'M103',
    "usa:A67_T57_58":                        'T57hv',
    "usa:A68_T28_Prototype":                 'T28Pr',
    "usa:A69_T110E5":                        '110e5',
    "usa:A71_T21":                           'T21',
    "usa:A72_T25_2":                         'T25/2',
    "usa:A74_T1_E6":                         'T1e6',
    "usa:A78_M4_Improved":                   'M4·Imp',
    "usa:A80_T26_E4_SuperPershing":          'T26e4',
    "usa:A81_T95_E2":                        'T95e2',
    "usa:A83_T110E4":                        '110e4',
    "usa:A85_T110E3":                        '110e3',
    "usa:A86_T23E3":                         'T23e3',
    "usa:A87_M44":                           'M44',
    "usa:A88_M53_55":                        'M53·55',
    "usa:A89_T54E1":                         '54E1',
    "usa:A90_T69":                           'T69',
    "usa:A90_T69_IGR":                       'T69',
    "usa:A92_M60":                           'M60',
    "usa:A93_T7_Combat_Car":                 'T7·CC',
    "usa:A94_T37":                           'T37',
    "usa:A95_T95_E6":                        'T95e6',
    "usa:A97_M41_Bulldog":                   'Buldog',
    "usa:A99_T92_LT":                        't92lt',
    "ussr:Observer":                         '',
    "ussr:R01_IS":                           'Is',
    "ussr:R02_SU-85":                        'Su85',
    "ussr:R03_BT-7":                         'Bt7',
    "ussr:R03_BT-7_bootcamp":                'Bt7',
    "ussr:R04_T-34":                         't34',
    "ussr:R05_KV":                           'KV',
    "ussr:R06_T-28":                         't28',
    "ussr:R06_T-28_bootcamp":                't28',
    "ussr:R07_T-34-85":                      't34·85',
    "ussr:R07_T-34-85_bootcamp":             't34·85',
    "ussr:R08_BT-2":                         'Bt2',
    "ussr:R08_BT-2_bootcamp":                'Bt2',
    "ussr:R09_T-26":                         't26',
    "ussr:R09_T-26_bot":                     't26',
    "ussr:R100_SU122A":                      'Su122',
    "ussr:R101_MT25":                        'Mt·25',
    "ussr:R104_Object_430_II":               'obj430v2',
    "ussr:R105_BT_7A":                       'Bt7a',
    "ussr:R106_KV85":                        'Kv·85',
    "ussr:R106_KV85_IGR":                    'Kv·85',
    "ussr:R107_LTB":                         'LTB',
    "ussr:R108_T34_85M":                     't34·85m',
    "ussr:R109_T54S":                        't54obl',
    "ussr:R10_AT-1":                         'At1',
    "ussr:R110_Object_260":                  'obj260',
    "ussr:R111_ISU130":                      'isu130',
    "ussr:R112_T54_45":                      't54obr1',
    "ussr:R113_Object_730":                  'Is·5',
    "ussr:R114_Object_244":                  'obj244',
    "ussr:R115_IS-3_auto":                   'Is·3mz',
    "ussr:R116_ISU122C_Berlin":              'isu122c',
    "ussr:R117_T34_85_Rudy":                 'Rudy',
    "ussr:R118_T28_F30":                     't28f30',
    "ussr:R119_Object_777":                  'obj777',
    "ussr:R11_MS-1":                         'Ms·1',
    "ussr:R11_MS-1_bot":                     'Ms·1',
    "ussr:R120_T22SR_A22":                   't22sr',
    "ussr:R121_KV4_KTT":                     'Kv·4ktts',
    "ussr:R122_T44_100":                     't44·100',
    "ussr:R122_T44_100B":                    't44·100m',
    "ussr:R123_Kirovets_1":                  'Kirov1',
    "ussr:R125_T_45":                        't45',
    "ussr:R126_Object_730_5":                'obj268v5',
    "ussr:R127_T44_100_P":                   't44·100P',
    "ussr:R128_KV4_Kreslavskiy":             'Kv·4·Kresl',
    "ussr:R129_Object_257":                  'obj257',
    "ussr:R12_A-20":                         'A·20',
    "ussr:R131_Tank_Gavalov":                'ltg',
    "ussr:R132_VNII_100LT":                  't100lt',
    "ussr:R133_KV_122":                      'Kv122',
    "ussr:R134_Object_252K":                 'zashch',
    "ussr:R134_Object_252U":                 'obj252u',
    "ussr:R135_T_103":                       't103',
    "ussr:R13_KV-1s":                        'Kv·1s',
    "ussr:R140_M4_Loza":                     'M4·Lo',
    "ussr:R143_T_29":                        't·29',
    "ussr:R146_STG":                         'stg',
    "ussr:R146_STG_Tday":                    'gvard',
    "ussr:R14_SU-5":                         'Su·5',
    "ussr:R15_S-51":                         'S·51',
    "ussr:R16_SU-18":                        'Su·18',
    "ussr:R17_SU-100":                       'Su100',
    "ussr:R18_SU-152":                       'Su152',
    "ussr:R18_SU-152_IGR":                   'Su152',
    "ussr:R19_IS-3":                         'Is·3',
    "ussr:R19_IS-3_IGR":                     'Is·3',
    "ussr:R20_T-44":                         't44',
    "ussr:R20_T-44_IGR":                     't44',
    "ussr:R22_T-46":                         't46',
    "ussr:R22_T-46_bootcamp":                't46',
    "ussr:R23_T-43":                         't43',
    "ussr:R24_SU-76":                        'Su76',
    "ussr:R25_GAZ-74b":                      'Su85b',
    "ussr:R26_SU-8":                         'Su·8',
    "ussr:R27_SU-14":                        'Su·14',
    "ussr:R31_Valentine_LL":                 'Valnt',
    "ussr:R31_Valentine_LL_IGR":             'Valnt',
    "ussr:R32_Matilda_II_LL":                'Matil4',
    "ussr:R33_Churchill_LL":                 'Chrch3',
    "ussr:R34_BT-SV":                        'BtSV',
    "ussr:R38_KV-220":                       'Kv220',
    "ussr:R38_KV-220_beta":                  'Kv220·2t',
    "ussr:R39_KV-3":                         'Kv·3',
    "ussr:R40_T-54":                         't54',
    "ussr:R41_T-50":                         't50',
    "ussr:R42_T-60":                         't60',
    "ussr:R43_T-70":                         't70',
    "ussr:R43_T-70_bootcamp":                't70',
    "ussr:R44_T80":                          't80',
    "ussr:R45_IS-7":                         'Is·7',
    "ussr:R45_IS-7_IGR":                     'Is·7',
    "ussr:R45_IS-7_fallout":                 'Is·7',
    "ussr:R46_KV-13":                        'Kv·13',
    "ussr:R47_ISU-152":                      'ISU',
    "ussr:R47_ISU-152_IGR":                  'ISU',
    "ussr:R49_SU100Y":                       'Su100y',
    "ussr:R50_SU76I":                        'Su76i',
    "ussr:R50_SU76I_bootcamp":               'Su76i',
    "ussr:R51_Object_212":                   'obj212',
    "ussr:R52_Object_261":                   'obj261',
    "ussr:R53_Object_704":                   'obj704',
    "ussr:R54_KV-5":                         'Kv·5',
    "ussr:R54_KV-5_IGR":                     'Kv·5',
    "ussr:R56_T-127":                        't127',
    "ussr:R57_A43":                          'A·43',
    "ussr:R58_SU-101":                       'Su101',
    "ussr:R59_A44":                          'A·44',
    "ussr:R60_Object416":                    'obj416',
    "ussr:R61_Object252":                    'Is·6',
    "ussr:R61_Object252_BF":                 'Is·6bf',
    "ussr:R63_ST_I":                         'ST·I',
    "ussr:R66_SU-26":                        'Su·26',
    "ussr:R67_M3_LL":                        'M3lght',
    "ussr:R68_A-32":                         'A·32',
    "ussr:R70_T_50_2":                       '50·2',
    "ussr:R71_IS_2B":                        'Is·2B',
    "ussr:R72_T150":                         'T150',
    "ussr:R73_KV4":                          'Kv·4',
    "ussr:R74_SU100M1":                      'Su100m',
    "ussr:R75_SU122_54":                     '122·54',
    "ussr:R77_KV2":                          'Kv·2',
    "ussr:R77_KV2_IGR":                      'Kv·2',
    "ussr:R78_SU_85I":                       'Su85i',
    "ussr:R80_KV1":                          'Kv1',
    "ussr:R81_IS8":                          'T·10',
    "ussr:R84_Tetrarch_LL":                  'Tetrh',
    "ussr:R86_LTP":                          'Ltp',
    "ussr:R86_LTP_bootcamp":                 'Ltp',
    "ussr:R87_T62A":                         't62a',
    "ussr:R87_T62A_fallout":                 't62a',
    "ussr:R88_Object268":                    'obj268',
    "ussr:R89_SU122_44":                     '122·44',
    "ussr:R90_IS_4M":                        'Is·4',
    "ussr:R91_SU14_1":                       'Su14·1',
    "ussr:R93_Object263":                    'obj263',
    "ussr:R95_Object_907":                   'obj907',
    "ussr:R95_Object_907A":                  'obj907a',
    "ussr:R96_Object_430":                   'obj430',
    "ussr:R97_Object_140":                   'obj140',
    "ussr:R98_T44_85":                       't44·85',
    "ussr:R98_T44_85M":                      't44·85m',
    "ussr:R99_T44_122":                      't44·122'
    # Unused
    #"china:Ch04_T34_1_training":             't34·1',
    #"germany:G03_PzV_Panther_training":      'Pant',
    #"germany:G10_PzIII_AusfJ_training":      'Pz3',
    #"germany:G16_PzVIB_Tiger_II_training":   'Tig2',
    #"usa:A06_M4A3E8_Sherman_training":       'M4a3e8',
    #"ussr:R07_T-34-85_training":             't34·85',
}
