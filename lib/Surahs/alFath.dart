List <String> alFath =['بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ إِنَّا فَتَحْنَا لَكَ فَتْحًا مُّبِينًا', 'لِّيَغْفِرَ لَكَ ٱللَّهُ مَا تَقَدَّمَ مِن ذَنۢبِكَ وَمَا تَأَخَّرَ وَيُتِمَّ نِعْمَتَهُۥ عَلَيْكَ وَيَهْدِيَكَ صِرَٰطًا مُّسْتَقِيمًا', 'وَيَنصُرَكَ ٱللَّهُ نَصْرًا عَزِيزًا', 'هُوَ ٱلَّذِىٓ أَنزَلَ ٱلسَّكِينَةَ فِى قُلُوبِ ٱلْمُؤْمِنِينَ لِيَزْدَادُوٓا۟ إِيمَـٰنًا مَّعَ إِيمَـٰنِهِمْ ۗ وَلِلَّهِ جُنُودُ ٱلسَّمَـٰوَٰتِ وَٱلْأَرْضِ ۚ وَكَانَ ٱللَّهُ عَلِيمًا حَكِيمًا', 'لِّيُدْخِلَ ٱلْمُؤْمِنِينَ وَٱلْمُؤْمِنَـٰتِ جَنَّـٰتٍ تَجْرِى مِن تَحْتِهَا ٱلْأَنْهَـٰرُ خَـٰلِدِينَ فِيهَا وَيُكَفِّرَ عَنْهُمْ سَيِّـَٔاتِهِمْ ۚ وَكَانَ ذَٰلِكَ عِندَ ٱللَّهِ فَوْزًا عَظِيمًا', 'وَيُعَذِّبَ ٱلْمُنَـٰفِقِينَ وَٱلْمُنَـٰفِقَـٰتِ وَٱلْمُشْرِكِينَ وَٱلْمُشْرِكَـٰتِ ٱلظَّآنِّينَ بِٱللَّهِ ظَنَّ ٱلسَّوْءِ ۚ عَلَيْهِمْ دَآئِرَةُ ٱلسَّوْءِ ۖ وَغَضِبَ ٱللَّهُ عَلَيْهِمْ وَلَعَنَهُمْ وَأَعَدَّ لَهُمْ جَهَنَّمَ ۖ وَسَآءَتْ مَصِيرًا', 'وَلِلَّهِ جُنُودُ ٱلسَّمَـٰوَٰتِ وَٱلْأَرْضِ ۚ وَكَانَ ٱللَّهُ عَزِيزًا حَكِيمًا', 'إِنَّآ أَرْسَلْنَـٰكَ شَـٰهِدًا وَمُبَشِّرًا وَنَذِيرًا', 'لِّتُؤْمِنُوا۟ بِٱللَّهِ وَرَسُولِهِۦ وَتُعَزِّرُوهُ وَتُوَقِّرُوهُ وَتُسَبِّحُوهُ بُكْرَةً وَأَصِيلًا', 'إِنَّ ٱلَّذِينَ يُبَايِعُونَكَ إِنَّمَا يُبَايِعُونَ ٱللَّهَ يَدُ ٱللَّهِ فَوْقَ أَيْدِيهِمْ ۚ فَمَن نَّكَثَ فَإِنَّمَا يَنكُثُ عَلَىٰ نَفْسِهِۦ ۖ وَمَنْ أَوْفَىٰ بِمَا عَـٰهَدَ عَلَيْهُ ٱللَّهَ فَسَيُؤْتِيهِ أَجْرًا عَظِيمًا', 'سَيَقُولُ لَكَ ٱلْمُخَلَّفُونَ مِنَ ٱلْأَعْرَابِ شَغَلَتْنَآ أَمْوَٰلُنَا وَأَهْلُونَا فَٱسْتَغْفِرْ لَنَا ۚ يَقُولُونَ بِأَلْسِنَتِهِم مَّا لَيْسَ فِى قُلُوبِهِمْ ۚ قُلْ فَمَن يَمْلِكُ لَكُم مِّنَ ٱللَّهِ شَيْـًٔا إِنْ أَرَادَ بِكُمْ ضَرًّا أَوْ أَرَادَ بِكُمْ نَفْعًۢا ۚ بَلْ كَانَ ٱللَّهُ بِمَا تَعْمَلُونَ خَبِيرًۢا', 'بَلْ ظَنَنتُمْ أَن لَّن يَنقَلِبَ ٱلرَّسُولُ وَٱلْمُؤْمِنُونَ إِلَىٰٓ أَهْلِيهِمْ أَبَدًا وَزُيِّنَ ذَٰلِكَ فِى قُلُوبِكُمْ وَظَنَنتُمْ ظَنَّ ٱلسَّوْءِ وَكُنتُمْ قَوْمًۢا بُورًا', 'وَمَن لَّمْ يُؤْمِنۢ بِٱللَّهِ وَرَسُولِهِۦ فَإِنَّآ أَعْتَدْنَا لِلْكَـٰفِرِينَ سَعِيرًا', 'وَلِلَّهِ مُلْكُ ٱلسَّمَـٰوَٰتِ وَٱلْأَرْضِ ۚ يَغْفِرُ لِمَن يَشَآءُ وَيُعَذِّبُ مَن يَشَآءُ ۚ وَكَانَ ٱللَّهُ غَفُورًا رَّحِيمًا', 'سَيَقُولُ ٱلْمُخَلَّفُونَ إِذَا ٱنطَلَقْتُمْ إِلَىٰ مَغَانِمَ لِتَأْخُذُوهَا ذَرُونَا نَتَّبِعْكُمْ ۖ يُرِيدُونَ أَن يُبَدِّلُوا۟ كَلَـٰمَ ٱللَّهِ ۚ قُل لَّن تَتَّبِعُونَا كَذَٰلِكُمْ قَالَ ٱللَّهُ مِن قَبْلُ ۖ فَسَيَقُولُونَ بَلْ تَحْسُدُونَنَا ۚ بَلْ كَانُوا۟ لَا يَفْقَهُونَ إِلَّا قَلِيلًا', 'قُل لِّلْمُخَلَّفِينَ مِنَ ٱلْأَعْرَابِ سَتُدْعَوْنَ إِلَىٰ قَوْمٍ أُو۟لِى بَأْسٍ شَدِيدٍ تُقَـٰتِلُونَهُمْ أَوْ يُسْلِمُونَ ۖ فَإِن تُطِيعُوا۟ يُؤْتِكُمُ ٱللَّهُ أَجْرًا حَسَنًا ۖ وَإِن تَتَوَلَّوْا۟ كَمَا تَوَلَّيْتُم مِّن قَبْلُ يُعَذِّبْكُمْ عَذَابًا أَلِيمًا', 'لَّيْسَ عَلَى ٱلْأَعْمَىٰ حَرَجٌ وَلَا عَلَى ٱلْأَعْرَجِ حَرَجٌ وَلَا عَلَى ٱلْمَرِيضِ حَرَجٌ ۗ وَمَن يُطِعِ ٱللَّهَ وَرَسُولَهُۥ يُدْخِلْهُ جَنَّـٰتٍ تَجْرِى مِن تَحْتِهَا ٱلْأَنْهَـٰرُ ۖ وَمَن يَتَوَلَّ يُعَذِّبْهُ عَذَابًا أَلِيمًا', '۞ لَّقَدْ رَضِىَ ٱللَّهُ عَنِ ٱلْمُؤْمِنِينَ إِذْ يُبَايِعُونَكَ تَحْتَ ٱلشَّجَرَةِ فَعَلِمَ مَا فِى قُلُوبِهِمْ فَأَنزَلَ ٱلسَّكِينَةَ عَلَيْهِمْ وَأَثَـٰبَهُمْ فَتْحًا قَرِيبًا', 'وَمَغَانِمَ كَثِيرَةً يَأْخُذُونَهَا ۗ وَكَانَ ٱللَّهُ عَزِيزًا حَكِيمًا', 'وَعَدَكُمُ ٱللَّهُ مَغَانِمَ كَثِيرَةً تَأْخُذُونَهَا فَعَجَّلَ لَكُمْ هَـٰذِهِۦ وَكَفَّ أَيْدِىَ ٱلنَّاسِ عَنكُمْ وَلِتَكُونَ ءَايَةً لِّلْمُؤْمِنِينَ وَيَهْدِيَكُمْ صِرَٰطًا مُّسْتَقِيمًا', 'وَأُخْرَىٰ لَمْ تَقْدِرُوا۟ عَلَيْهَا قَدْ أَحَاطَ ٱللَّهُ بِهَا ۚ وَكَانَ ٱللَّهُ عَلَىٰ كُلِّ شَىْءٍ قَدِيرًا', 'وَلَوْ قَـٰتَلَكُمُ ٱلَّذِينَ كَفَرُوا۟ لَوَلَّوُا۟ ٱلْأَدْبَـٰرَ ثُمَّ لَا يَجِدُونَ وَلِيًّا وَلَا نَصِيرًا', 'سُنَّةَ ٱللَّهِ ٱلَّتِى قَدْ خَلَتْ مِن قَبْلُ ۖ وَلَن تَجِدَ لِسُنَّةِ ٱللَّهِ تَبْدِيلًا', 'وَهُوَ ٱلَّذِى كَفَّ أَيْدِيَهُمْ عَنكُمْ وَأَيْدِيَكُمْ عَنْهُم بِبَطْنِ مَكَّةَ مِنۢ بَعْدِ أَنْ أَظْفَرَكُمْ عَلَيْهِمْ ۚ وَكَانَ ٱللَّهُ بِمَا تَعْمَلُونَ بَصِيرًا', 'هُمُ ٱلَّذِينَ كَفَرُوا۟ وَصَدُّوكُمْ عَنِ ٱلْمَسْجِدِ ٱلْحَرَامِ وَٱلْهَدْىَ مَعْكُوفًا أَن يَبْلُغَ مَحِلَّهُۥ ۚ وَلَوْلَا رِجَالٌ مُّؤْمِنُونَ وَنِسَآءٌ مُّؤْمِنَـٰتٌ لَّمْ تَعْلَمُوهُمْ أَن تَطَـُٔوهُمْ فَتُصِيبَكُم مِّنْهُم مَّعَرَّةٌۢ بِغَيْرِ عِلْمٍ ۖ لِّيُدْخِلَ ٱللَّهُ فِى رَحْمَتِهِۦ مَن يَشَآءُ ۚ لَوْ تَزَيَّلُوا۟ لَعَذَّبْنَا ٱلَّذِينَ كَفَرُوا۟ مِنْهُمْ عَذَابًا أَلِيمًا', 'إِذْ جَعَلَ ٱلَّذِينَ كَفَرُوا۟ فِى قُلُوبِهِمُ ٱلْحَمِيَّةَ حَمِيَّةَ ٱلْجَـٰهِلِيَّةِ فَأَنزَلَ ٱللَّهُ سَكِينَتَهُۥ عَلَىٰ رَسُولِهِۦ وَعَلَى ٱلْمُؤْمِنِينَ وَأَلْزَمَهُمْ كَلِمَةَ ٱلتَّقْوَىٰ وَكَانُوٓا۟ أَحَقَّ بِهَا وَأَهْلَهَا ۚ وَكَانَ ٱللَّهُ بِكُلِّ شَىْءٍ عَلِيمًا', 'لَّقَدْ صَدَقَ ٱللَّهُ رَسُولَهُ ٱلرُّءْيَا بِٱلْحَقِّ ۖ لَتَدْخُلُنَّ ٱلْمَسْجِدَ ٱلْحَرَامَ إِن شَآءَ ٱللَّهُ ءَامِنِينَ مُحَلِّقِينَ رُءُوسَكُمْ وَمُقَصِّرِينَ لَا تَخَافُونَ ۖ فَعَلِمَ مَا لَمْ تَعْلَمُوا۟ فَجَعَلَ مِن دُونِ ذَٰلِكَ فَتْحًا قَرِيبًا', 'هُوَ ٱلَّذِىٓ أَرْسَلَ رَسُولَهُۥ بِٱلْهُدَىٰ وَدِينِ ٱلْحَقِّ لِيُظْهِرَهُۥ عَلَى ٱلدِّينِ كُلِّهِۦ ۚ وَكَفَىٰ بِٱللَّهِ شَهِيدًا', 'مُّحَمَّدٌ رَّسُولُ ٱللَّهِ ۚ وَٱلَّذِينَ مَعَهُۥٓ أَشِدَّآءُ عَلَى ٱلْكُفَّارِ رُحَمَآءُ بَيْنَهُمْ ۖ تَرَىٰهُمْ رُكَّعًا سُجَّدًا يَبْتَغُونَ فَضْلًا مِّنَ ٱللَّهِ وَرِضْوَٰنًا ۖ سِيمَاهُمْ فِى وُجُوهِهِم مِّنْ أَثَرِ ٱلسُّجُودِ ۚ ذَٰلِكَ مَثَلُهُمْ فِى ٱلتَّوْرَىٰةِ ۚ وَمَثَلُهُمْ فِى ٱلْإِنجِيلِ كَزَرْعٍ أَخْرَجَ شَطْـَٔهُۥ فَـَٔازَرَهُۥ فَٱسْتَغْلَظَ فَٱسْتَوَىٰ عَلَىٰ سُوقِهِۦ يُعْجِبُ ٱلزُّرَّاعَ لِيَغِيظَ بِهِمُ ٱلْكُفَّارَ ۗ وَعَدَ ٱللَّهُ ٱلَّذِينَ ءَامَنُوا۟ وَعَمِلُوا۟ ٱلصَّـٰلِحَـٰتِ مِنْهُم مَّغْفِرَةً وَأَجْرًا عَظِيمًۢا', 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ يَـٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ لَا تُقَدِّمُوا۟ بَيْنَ يَدَىِ ٱللَّهِ وَرَسُولِهِۦ ۖ وَٱتَّقُوا۟ ٱللَّهَ ۚ إِنَّ ٱللَّهَ سَمِيعٌ عَلِيمٌ'];