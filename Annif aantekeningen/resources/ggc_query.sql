select
  tt.maa1,
  tt.maa2,
  tt.ppn,
  tt.jvu_van as jvu_1100,
  array_to_string(tt.ta1, ' ; ') as taal_1500_publ,
  array_to_string(tt.ta3, ' ; ') as taal_1500_orig,
  (select field_value from kb.title_details where ppn = tt.ppn and tag_pp = '004A' and tag_gen_counter = 1 and field = 'A') as isbn_2000,
  (select field_value from kb.title_details where ppn = tt.ppn and tag_pp = '045M' and tag_occurrence = '01' and tag_counter = 1 and field = 'a') as unesco_1121,
  (select field_value from kb.title_details where ppn = tt.ppn and tag_pp = '045M' and tag_occurrence = '02' and tag_counter = 1 and field = 'a') as unesco_1122,
  array_to_string(array(select field_value from kb.title_details where ppn = tt.ppn and tag_pp = '045B' and field = 'a'), ' ; ') as nur_codes_5061,
  array_to_string(array(select field_value from kb.title_details where ppn = tt.ppn and tag_pp = '044Z' and field = '8' order by tag_gen_counter), ' | ') as brinkman_520X,
  array_to_string(array(select field_value from kb.title_details where ppn = tt.ppn and tag_pp = '044Z' and field = '9' order by tag_gen_counter), ' | ') as brinkman_520X_ppn,
  array_to_string
  (
    array
    (
      select
        cd.field_value
      from
                   kb.copy_details cd
        inner join kb.title_copies tc on tc.epn = cd.epn
      where
        tc.ppn    = tt.ppn and
        cd.tag_pp = '207F' and
        cd.field  = '0'
      order by
        tc.copy_counter,
        cd.tag_gen_counter
    ), ' ; '
  ) as onix_7880,
  public.isbd_author('kb', tt.ppn , '028A', 1) as prim_auteur_3000,
  public.isbd_author('kb', tt.ppn , '028C', 1) as  sec_auteur_3011,
  (select field_value from kb.title_details where ppn = tt.ppn and tag_pp = '021A' and tag_gen_counter = 1 and field = 'a' and field_counter = 1) as titel_4000,
  (select field_value from kb.title_details where ppn = tt.ppn and tag_pp = '021A' and tag_gen_counter = 1 and field = 'd' and field_counter = 1) as ondertitel_4000,
  td.field_value as samenvatting_4207
from
             kb.titles        tt
  inner join kb.title_details td on td.ppn = tt.ppn and td.tag_pp = '047I' and td.tag_gen_counter = 1 and td.field = 'a'         --KMC 4207 moet aanwezig zijn
  inner join kb.title_details te on te.ppn = tt.ppn and te.tag_pp = '044Z' and te.tag_gen_counter = 1 and te.field_position = 1  --KMC 520X moet aanwezig zijn
where
  tt.jvu_van between '2015' and '2019' and
  '{ned}' <@ tt.ta1
limit 100000;